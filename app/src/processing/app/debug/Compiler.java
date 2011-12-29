/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Part of the Processing project - http://processing.org

  Copyright (c) 2004-08 Ben Fry and Casey Reas
  Copyright (c) 2001-04 Massachusetts Institute of Technology

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

package processing.app.debug;

import processing.app.Base;
import processing.app.Preferences;
import processing.app.Sketch;
import processing.app.SketchCode;
import processing.core.*;

import java.io.*;
import java.util.*;
import java.util.zip.*;


public class Compiler implements MessageConsumer {
  static final String BUGS_URL =
    "http://code.google.com/p/arduino/issues/list";
  static final String SUPER_BADNESS =
    "Compiler error, please submit this code to " + BUGS_URL;

  Sketch sketch;
  String buildPath;
  String primaryClassName;
  boolean verbose;

  RunnerException exception;

  public Compiler() { }

  /**
   * Get core path, ie, where all core sources reside.
   *
   * @param boardPreferences board preferences
   * @return Core path, in String format
   */
  private static final String getCorePath(Map<String, String> boardPreferences)
  {
    String corePath;
    String core = boardPreferences.get("build.core");

    if (core.indexOf(':') == -1) {
      Target t = Base.getTarget();
      File coreFolder = new File(new File(t.getFolder(), "cores"), core);
      corePath = coreFolder.getAbsolutePath();
    } else {
      Target t = Base.targetsTable.get(core.substring(0, core.indexOf(':')));
      File coresFolder = new File(t.getFolder(), "cores");
      File coreFolder = new File(coresFolder, core.substring(core.indexOf(':') + 1));
      corePath = coreFolder.getAbsolutePath();
    }
    return corePath;
  }

  /**
   * Get all source files in a given path
   *
   * @param path Path where to search
   * @param recurse Whether or not to recuse into subdirectories
   * @return List of source files found
   */
  public static List<File> getAllSourcesInPath( String path, boolean recurse ) {
    List<File> sources = findFilesInPath(path, "S", recurse);
    sources.addAll( findFilesInPath(path, "c", recurse) );
    sources.addAll( findFilesInPath(path, "cpp", recurse) );
    return sources;
  }

  public boolean generateSmallFS(File smallfsdir, String builddir, String toolchain)
  {
      List cmd = new ArrayList();
      String extension="";
      String toolPath;

      if (Base.isLinux()) {
          toolPath = new String(Base.getHardwarePath() + File.separator +
                                "tools");

      } else {
          extension=".exe";
          toolPath = Base.getAvrBasePath(toolchain);
      }

      cmd.add(toolPath + File.separator + "mksmallfs" + extension);
      cmd.add(builddir + File.separator + "smallfs.dat" );

      cmd.add(smallfsdir.getPath());
      try {
          execAsynchronously(cmd, toolPath);
      } catch (RunnerException e) {
          System.err.print(e.getMessage());
          return false;
      }

      return true;
  }

  /**
   * Compile sketch
   *
   * @param sketch Sketch object to be compiled.
   * @param buildPath Where the temporary files live and will be built from.
   * @param primaryClassName the name of the combined sketch file w/ extension
   * @return true if successful.
   * @throws RunnerException Only if there's a problem. Only then.
   */
  public boolean compile(Sketch sketch,
                         String buildPath,
                         String primaryClassName,
                         boolean verbose) throws RunnerException {
    this.sketch = sketch;
    this.buildPath = buildPath;
    this.primaryClassName = primaryClassName;
    this.verbose = verbose;

    // the pms object isn't used for anything but storage
    MessageStream pms = new MessageStream(this);

    Map<String, String> boardPreferences = Base.getBoardPreferences();
    String core = boardPreferences.get("build.core");
    String toolchain = boardPreferences.get("build.toolchain");

    if (core == null) {
      RunnerException re = new RunnerException("No board selected; please choose a board from the Tools > Board menu.");
      re.hideStackTrace();
      throw re;
    }

    String avrBasePath = Base.getAvrBasePath(toolchain);

    String corePath = getCorePath(boardPreferences);

    String variant = boardPreferences.get("build.variant");
    String variantPath = null;
    
    if (variant != null) {
      if (variant.indexOf(':') == -1) {
	Target t = Base.getTarget();
	File variantFolder = new File(new File(t.getFolder(), "variants"), variant);
	variantPath = variantFolder.getAbsolutePath();
      } else {
	Target t = Base.targetsTable.get(variant.substring(0, variant.indexOf(':')));
	File variantFolder = new File(t.getFolder(), "variants");
	variantFolder = new File(variantFolder, variant.substring(variant.indexOf(':') + 1));
	variantPath = variantFolder.getAbsolutePath();
      }
    }
   sketch.setCompilingProgress(20);


    List<String> extracflags=new ArrayList<String>();
    String classFileName = Base.getFileNameWithoutExtension(new File(primaryClassName));

    createFolder( new File(buildPath, ".deps") );
    // Create a suitable makefile

    try {

      File commonMakeFileName = new File(buildPath, "Common.mak");
      File rulesMakeFileName = new File(corePath,"Rules.mak");

      Makefile commonMakeFile = new Makefile(commonMakeFileName);

      /* Add all board settings to Common.mak */
      for (String key: boardPreferences.keySet()) {
        commonMakeFile.setVariable( "PREFS___board___" + Makefile.makeVariable(key), boardPreferences.get(key));
      }
      /* Add also some useful variables */
      commonMakeFile.setVariable("COREPATH", corePath);
      commonMakeFile.setVariable("AVRPATH", avrBasePath);
      commonMakeFile.setVariable("BUILDPATH", buildPath);
      commonMakeFile.setVariable("REVISION", new Integer(Base.REVISION).toString());

      Makefile mainMakeFile = new Makefile( new File(buildPath, "Makefile") );

      mainMakeFile.addDependency("all","all-target");
      mainMakeFile.include( commonMakeFile );


      mainMakeFile.setVariable("TARGET",classFileName);

      if (variantPath != null) {
          commonMakeFile.appendVariable("EXTRACFLAGS","-I" + variantPath);
      }

      /* Place core makefile in core subdirectory */

      File coreFolder = new File(buildPath, "core");
      File coreDepsFolder   = new File(buildPath, "core" + File.separator + ".deps" );
      createFolder(coreFolder);
      createFolder(coreDepsFolder);

      Makefile coreMakeFile = new Makefile( new File(coreFolder, "Makefile") );
      coreMakeFile.include( commonMakeFile );

      /* Get all source files for core */
      List<File> coreSources = getAllSourcesInPath(corePath,true);
      File libCoreFile = new File(coreFolder,"libcore.a");

      coreMakeFile.addDependency( libCoreFile, Makefile.makeObjectsFromSources(coreSources) );
      coreMakeFile.addBuildRule("$(AR) $(ARFLAGS) $@ $+");

      // Copy files into place

      for (File file : coreSources) {
        // Only copy files if not modified
        File target = new File(coreFolder,file.getName());
        if (! target.exists() || target.lastModified()!=file.lastModified()) {
          Base.copyFile( file, target );
        }
        coreMakeFile.addDependency( Makefile.makeObjectFromSource(file), file );
        coreMakeFile.includeIfExists("." + File.separator + ".deps" + File.separator +
                                     Base.getFileNameWithoutExtension(file) + ".Tpo" );

      }

      coreMakeFile.appendVariable("EXTRACFLAGS","-I" + buildPath);
      coreMakeFile.include( rulesMakeFileName );
      coreMakeFile.close();

      // Write core dependency

      mainMakeFile.addDependency(".PHONY", "core" + File.separator + "libcore.a");
      mainMakeFile.addDependency("core" + File.separator + "libcore.a","");
      mainMakeFile.addBuildRule("$(MAKE) -C core libcore.a");

      for (File libraryFolder : sketch.getImportedLibraries()) {

        File outputFolder = new File(buildPath, libraryFolder.getName());
        File depsFolder   = new File(buildPath, libraryFolder.getName() + File.separator + ".deps" );
        File utilityFolder = new File(libraryFolder, "utility");
        String libraryName = "lib" + libraryFolder.getName();
        File libraryFile = new File(libraryFolder, libraryName + ".a");

        createFolder(outputFolder);
        createFolder(depsFolder);

        /* Get all sources for this library */
        List<File> libSources = getAllSourcesInPath(libraryFolder.getPath(),false);
        // Specific makefile for this library
        Makefile libMakeFile = new Makefile(new File(outputFolder, "Makefile"));

        libMakeFile.include( commonMakeFile );

        libMakeFile.appendVariable("EXTRACFLAGS","-I" + libraryFolder.getPath());

        // Copy files into place
        for (File file : libSources) {
          // Don't copy if not modifies
          File target = new File(outputFolder,file.getName());

          if (! target.exists() || target.lastModified()!=file.lastModified()) {
            Base.copyFile( file, target );
          }
          libMakeFile.addDependency( Makefile.makeObjectFromSource(file), file );
          libMakeFile.includeIfExists("." + File.separator + ".deps" + File.separator +
                                     Base.getFileNameWithoutExtension(file) + ".Tpo" );
        }

        if (utilityFolder.exists()) {
          String utilityRelativePath = libraryFolder.getName() + File.separator + "utility";
          File utilityPath = new File( libraryFolder.getPath() + File.separator + "utility" );

          libMakeFile.appendVariable("EXTRACFLAGS","-I" + utilityPath.getPath());
          // This should not be needed.
          commonMakeFile.appendVariable("EXTRACFLAGS","-I" + utilityPath.getPath());

          List<File> utilitySources = getAllSourcesInPath(utilityFolder.getPath(),false);

          if (utilitySources.size() > 0) {
            File utilityLibFile = new File("libutility.a");
            outputFolder = new File(outputFolder, "utility");
            createFolder(outputFolder);
            createFolder(new File(outputFolder,".deps"));

            // Append to main makefile, so it's included also
            mainMakeFile.appendVariable( "LIBS", utilityRelativePath + File.separator + utilityLibFile.getName() );
            mainMakeFile.addDependency(".PHONY", utilityRelativePath + File.separator + utilityLibFile.getName());
            mainMakeFile.addDependency(utilityRelativePath + File.separator + utilityLibFile.getName(), "");
            mainMakeFile.addBuildRule("$(MAKE) -C " + utilityRelativePath + " " + utilityLibFile.getName());

            // Now, create utility makefile
            Makefile utilityMakeFile = new Makefile( new File(outputFolder, "Makefile") );
            utilityMakeFile.include(commonMakeFile);

            for (File file : utilitySources) {
              File target = new File(outputFolder,file.getName());

              if (! target.exists() || target.lastModified()!=file.lastModified()) {
                Base.copyFile( file, target );
              }
              utilityMakeFile.addDependency( Makefile.makeObjectFromSource(file), file );
              utilityMakeFile.includeIfExists("." + File.separator + ".deps" + File.separator +
                                     Base.getFileNameWithoutExtension(file) + ".Tpo" );

            }

            utilityMakeFile.addDependency( utilityLibFile, Makefile.makeObjectsFromSources(utilitySources) );
            utilityMakeFile.addBuildRule("$(AR) $(ARFLAGS) $@ $+");
            utilityMakeFile.include( rulesMakeFileName );
            utilityMakeFile.close();

            libMakeFile.addDependency(libraryFolder.getName()+ File.separator + libraryName + ".a", "");
            libMakeFile.addBuildRule("$(MAKE) -C " + libraryFolder.getName() + " " + libraryName + ".a");

          }
        }

        // this library can use includes in its utility/ folder
        libMakeFile.addDependency( libraryFile, Makefile.makeObjectsFromSources(libSources) );
        libMakeFile.addBuildRule("$(AR) $(ARFLAGS) $@ $+");

        libMakeFile.include( rulesMakeFileName );
        libMakeFile.close();

        // This is stupid, but some libs require other libs (ex. Ethernet needs SPI)
        commonMakeFile.appendVariable("EXTRACFLAGS","-I" + libraryFolder.getPath());

        mainMakeFile.appendVariable("LIBS", libraryFolder.getName()+ File.separator + libraryName + ".a");
        // Enforce recheck for library files
        mainMakeFile.addDependency(".PHONY", libraryFolder.getName()+ File.separator + libraryName + ".a");

        mainMakeFile.addDependency(libraryFolder.getName()+ File.separator + libraryName + ".a", "");
        mainMakeFile.addBuildRule("$(MAKE) -C " + libraryFolder.getName() + " " + libraryName + ".a");

      }

      List<File> sketchSources = getAllSourcesInPath(buildPath,false);

      mainMakeFile.setVariable("TARGETOBJ", Makefile.makeFileList(Makefile.makeObjectsFromSources(sketchSources)) );
      mainMakeFile.appendVariable("LIBS","core" + File.separator + libCoreFile.getName());
      mainMakeFile.include( rulesMakeFileName );

      // Check for smallfs

      File smallfsdir = new File(sketch.getFolder(),"smallfs");
      if (smallfsdir.isDirectory()) {
          //System.err.println("Found smallfs directory");
          generateSmallFS( smallfsdir, buildPath, toolchain);
      }


      mainMakeFile.close();

      commonMakeFile.close();

    } catch (java.io.IOException e) {
      throw new RunnerException("Cannot write makefile!");
    }
    sketch.setCompilingProgress(50);
    return runMake(avrBasePath, buildPath);
  }


  private boolean runMake(String avrBasePath,
                          String buildPath)
  throws RunnerException {

      // TODO: make sure this works in Win32
    List baseCommandMake = new ArrayList(Arrays.asList(new String[] {
      avrBasePath + "make", "--silent", "-C", buildPath, "all"}));

    execAsynchronously(baseCommandMake, avrBasePath);
    return true;

  }

  boolean firstErrorFound;
  boolean secondErrorFound;

  /**
   * Either succeeds or throws a RunnerException fit for public consumption.
   */
  private void execAsynchronously(List commandList, String path) throws RunnerException {
    String[] command = new String[commandList.size()];
    commandList.toArray(command);
    int result = 0;
    
    if (verbose || Preferences.getBoolean("build.verbose")) {
      for(int j = 0; j < command.length; j++) {
        System.out.print(command[j] + " ");
      }
      System.out.println();
    }

    firstErrorFound = false;  // haven't found any errors yet
    secondErrorFound = false;

    Process process;
    String [] envp = new String[] {
        "PATH="  + System.getenv("PATH") + ";" + path,
        "TEMP=" + System.getenv("TEMP")
    };
    
    try {
        if(Base.isLinux()) {
            process = Runtime.getRuntime().exec(command);
        } else {
            process = Runtime.getRuntime().exec(command, envp);
        }
    } catch (IOException e) {
      RunnerException re = new RunnerException(e.getMessage());
      re.hideStackTrace();
      throw re;
    }

    MessageSiphon in = new MessageSiphon(process.getInputStream(), this);
    MessageSiphon err = new MessageSiphon(process.getErrorStream(), this);

    // wait for the process to finish.  if interrupted
    // before waitFor returns, continue waiting
    boolean compiling = true;
    while (compiling) {
      try {
        if (in.thread != null)
          in.thread.join();
        if (err.thread != null)
          err.thread.join();
        result = process.waitFor();
        //System.out.println("result is " + result);
        compiling = false;
      } catch (InterruptedException ignored) { }
    }

    // an error was queued up by message(), barf this back to compile(),
    // which will barf it back to Editor. if you're having trouble
    // discerning the imagery, consider how cows regurgitate their food
    // to digest it, and the fact that they have five stomaches.
    //
    //System.out.println("throwing up " + exception);
    if (exception != null) { throw exception; }

    if (result > 1) {
      // a failure in the tool (e.g. unable to locate a sub-executable)
      System.err.println(command[0] + " returned " + result);
    }

    if (result != 0) {
      RunnerException re = new RunnerException("Error compiling.");
      re.hideStackTrace();
      throw re;
    }
  }


  /**
   * Part of the MessageConsumer interface, this is called
   * whenever a piece (usually a line) of error message is spewed
   * out from the compiler. The errors are parsed for their contents
   * and line number, which is then reported back to Editor.
   */
  public void message(String s) {
    int i;

    // remove the build path so people only see the filename
    // can't use replaceAll() because the path may have characters in it which
    // have meaning in a regular expression.
    if (!verbose) {
      while ((i = s.indexOf(buildPath + File.separator)) != -1) {
        s = s.substring(0, i) + s.substring(i + (buildPath + File.separator).length());
      }
    }
  
    // look for error line, which contains file name, line number,
    // and at least the first line of the error message
    String errorFormat = "([\\w\\d_]+.\\w+):(\\d+):\\s*error:\\s*(.*)\\s*";
    String[] pieces = PApplet.match(s, errorFormat);

//    if (pieces != null && exception == null) {
//      exception = sketch.placeException(pieces[3], pieces[1], PApplet.parseInt(pieces[2]) - 1);
//      if (exception != null) exception.hideStackTrace();
//    }
    
    if (pieces != null) {
      String error = pieces[3], msg = "";
      
      if (pieces[3].trim().equals("SPI.h: No such file or directory")) {
        error = "Please import the SPI library from the Sketch > Import Library menu.";
        msg = "\nAs of Arduino 0019, the Ethernet library depends on the SPI library." +
              "\nYou appear to be using it or another library that depends on the SPI library.\n\n";
      }
      
      if (pieces[3].trim().equals("'BYTE' was not declared in this scope")) {
        error = "The 'BYTE' keyword is no longer supported.";
        msg = "\nAs of Arduino 1.0, the 'BYTE' keyword is no longer supported." +
              "\nPlease use Serial.write() instead.\n\n";
      }
      
      if (pieces[3].trim().equals("no matching function for call to 'Server::Server(int)'")) {
        error = "The Server class has been renamed EthernetServer.";
        msg = "\nAs of Arduino 1.0, the Server class in the Ethernet library " +
              "has been renamed to EthernetServer.\n\n";
      }
      
      if (pieces[3].trim().equals("no matching function for call to 'Client::Client(byte [4], int)'")) {
        error = "The Client class has been renamed EthernetClient.";
        msg = "\nAs of Arduino 1.0, the Client class in the Ethernet library " +
              "has been renamed to EthernetClient.\n\n";
      }
      
      if (pieces[3].trim().equals("'Udp' was not declared in this scope")) {
        error = "The Udp class has been renamed EthernetUdp.";
        msg = "\nAs of Arduino 1.0, the Udp class in the Ethernet library " +
              "has been renamed to EthernetClient.\n\n";
      }
      
      if (pieces[3].trim().equals("'class TwoWire' has no member named 'send'")) {
        error = "Wire.send() has been renamed Wire.write().";
        msg = "\nAs of Arduino 1.0, the Wire.send() function was renamed " +
              "to Wire.write() for consistency with other libraries.\n\n";
      }
      
      if (pieces[3].trim().equals("'class TwoWire' has no member named 'receive'")) {
        error = "Wire.receive() has been renamed Wire.read().";
        msg = "\nAs of Arduino 1.0, the Wire.receive() function was renamed " +
              "to Wire.read() for consistency with other libraries.\n\n";
      }

      RunnerException e = sketch.placeException(error, pieces[1], PApplet.parseInt(pieces[2]) - 1);

      // replace full file path with the name of the sketch tab (unless we're
      // in verbose mode, in which case don't modify the compiler output)
      if (e != null && !verbose) {
        SketchCode code = sketch.getCode(e.getCodeIndex());
        String fileName = code.isExtension(sketch.getDefaultExtension()) ? code.getPrettyName() : code.getFileName();
        s = fileName + ":" + e.getCodeLine() + ": error: " + pieces[3] + msg;        
      }
            
      if (exception == null && e != null) {
        exception = e;
        exception.hideStackTrace();
      }      
    }
    
    System.err.print(s);
  }

  /////////////////////////////////////////////////////////////////////////////


  /////////////////////////////////////////////////////////////////////////////

  static private void createFolder(File folder) throws RunnerException {
    if (folder.isDirectory()) return;
    if (!folder.mkdir())
      throw new RunnerException("Couldn't create: " + folder);
  }

  /**
   * Given a folder, return a list of the header files in that folder (but
   * not the header files in its sub-folders, as those should be included from
   * within the header files at the top-level).
   */
  static public String[] headerListFromIncludePath(String path) {
    FilenameFilter onlyHFiles = new FilenameFilter() {
      public boolean accept(File dir, String name) {
        return name.endsWith(".h");
      }
    };
    
    return (new File(path)).list(onlyHFiles);
  }
  
  static public ArrayList<File> findFilesInPath(String path, String extension,
                                                boolean recurse) {
    return findFilesInFolder(new File(path), extension, recurse);
  }
  
  static public ArrayList<File> findFilesInFolder(File folder, String extension,
                                                  boolean recurse) {
    ArrayList<File> files = new ArrayList<File>();
    
    if (folder.listFiles() == null) return files;
    
    for (File file : folder.listFiles()) {
      if (file.getName().startsWith(".")) continue; // skip hidden files
      
      if (file.getName().endsWith("." + extension))
        files.add(file);
        
      if (recurse && file.isDirectory()) {
        files.addAll(findFilesInFolder(file, extension, true));
      }
    }
    
    return files;
  }
}
