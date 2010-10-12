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

  public static List<File> getAllSourcesInPath( String path, boolean recurse ) {
    List<File> sources = findFilesInPath(path, "S", recurse);
    sources.addAll( findFilesInPath(path, "c", recurse) );
    sources.addAll( findFilesInPath(path, "cpp", recurse) );
    return sources;
  }

  public static final String makeMakeFileVariable(String name) {
    name = name.replace(".","___");
    return name;
  }
  /**
   * Compile with avr-gcc.
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

    String avrBasePath = Base.getAvrBasePath();
    Map<String, String> boardPreferences = Base.getBoardPreferences();

    String core = boardPreferences.get("build.core");
    if (core == null) {
      RunnerException re = new RunnerException("No board selected; please choose a board from the Tools > Board menu.");
      re.hideStackTrace();
      throw re;
    }

    String corePath = getCorePath(boardPreferences);
    List<File> objectFiles = new ArrayList<File>();
    List includePaths = new ArrayList();
    includePaths.add(corePath);

    String runtimeLibraryName = buildPath + File.separator + "core/libcore.a";

    List<String> extracflags=new ArrayList<String>();
    String classFileName = Base.getFileNameWithoutExtension(new File(primaryClassName));

    String extracppflags = boardPreferences.get("build.extraCflags");
    if (null!=extracppflags) {
      String [] flagList = processing.core.PApplet.split(extracppflags," ");
      for (String flag: flagList)
        extracflags.add(flag);
    }

    // Create a suitable makefile
    BufferedWriter makeFile;
    try {

      /* Write preferences */
      BufferedWriter commonMakeFile = new BufferedWriter(new FileWriter(new File(buildPath, "Common.mak")));
      for (String key: boardPreferences.keySet()) {
        commonMakeFile.write( "PREFS___board___" + makeMakeFileVariable(key) +"="+ boardPreferences.get(key));
        commonMakeFile.newLine();
      }
      commonMakeFile.write("COREPATH=" + corePath);
      commonMakeFile.newLine();
      commonMakeFile.write("AVRPATH=" + avrBasePath);
      commonMakeFile.newLine();
      commonMakeFile.write("BUILDPATH=" + buildPath);
      commonMakeFile.newLine();
      commonMakeFile.write("REVISION=" + Base.REVISION);
      commonMakeFile.newLine();

      commonMakeFile.close();

      makeFile = new BufferedWriter(new FileWriter(new File(buildPath, "Makefile")));
      makeFile.write("include Common.mak");
      makeFile.newLine();


      makeFile.write("TARGET=" + classFileName);
      makeFile.newLine();
      makeFile.newLine();

      /* Place core file in core subdirectory */

      File coreFolder = new File(buildPath, "core");
      createFolder(coreFolder);
      BufferedWriter coreMakeFile = new BufferedWriter(new FileWriter(new File(coreFolder, "Makefile")));

      coreMakeFile.write("include " + ".." + File.separator + "Common.mak");
      coreMakeFile.newLine();

      /* Get all source files for core */
      List<File> coreSources = getAllSourcesInPath(corePath,true);


      coreMakeFile.write("libcore.a:");
      for (File file : coreSources) {
        coreMakeFile.write(" " + Base.getFileNameWithoutExtension(file) + ".o");
      }
      //			coreMakeFile.newLine();
      coreMakeFile.newLine();
      coreMakeFile.write("\t$(AR) $(ARFLAGS) $@ $+");
      coreMakeFile.newLine();

      // Copy files into place

      for (File file : coreSources) {
        Base.copyFile( file, new File(coreFolder,file.getName()));
        coreMakeFile.write( Base.getFileNameWithoutExtension(file) + ".o: "+  file.getName());
        coreMakeFile.newLine();
      }
      extracflags.add("-I" + buildPath);
      coreMakeFile.write("EXTRACFLAGS=");
      for (String f: extracflags) {
        coreMakeFile.write(f + " ");
      }
      coreMakeFile.newLine();
      coreMakeFile.write("include " + corePath + File.separator + "Rules.mak");
      coreMakeFile.newLine();


      coreMakeFile.close();

      // Write core dependency

      makeFile.write("core" + File.separator + "libcore.a:");
      makeFile.newLine();
      makeFile.write("\t$(MAKE) -C core libcore.a");
      makeFile.newLine();

      // use library directories as include paths for all libraries
      for (File file : sketch.getImportedLibraries()) {
        extracflags.add("-I"+file.getPath());
      }


      for (File libraryFolder : sketch.getImportedLibraries()) {
        File outputFolder = new File(buildPath, libraryFolder.getName());
        File utilityFolder = new File(libraryFolder, "utility");
        String libraryName = "lib" + libraryFolder.getName();

        createFolder(outputFolder);

        /* Get all sources for this library */
        List<File> libSources = getAllSourcesInPath(libraryFolder.getPath(),false);
        // Specific makefile for this library
        BufferedWriter libMakeFile = new BufferedWriter(new FileWriter(new File(outputFolder, "Makefile")));

        libMakeFile.write("include " + ".." + File.separator + "Common.mak");
        libMakeFile.newLine();

        libMakeFile.write( libraryName +  ".a: ");

        // Copy files into place
        for (File file : libSources) {
          Base.copyFile( file, new File(outputFolder,file.getName()));
          libMakeFile.write( Base.getFileNameWithoutExtension(file) + ".o ");
        }
        libMakeFile.newLine();
        libMakeFile.write("\t$(AR) $(ARFLAGS) $@ $+");
        libMakeFile.newLine();

        outputFolder = new File(outputFolder, "utility");
        createFolder(outputFolder);

        List<File> utilitySources = getAllSourcesInPath(utilityFolder.getPath(),false);

        for (File file : utilitySources) {
          Base.copyFile( file, new File(utilityFolder,file.getName()));
        }
        // TODO: add utility makefile

        // this library can use includes in its utility/ folder

        libMakeFile.write("EXTRACFLAGS=-I" + libraryFolder.getPath());
        libMakeFile.newLine();

        makeFile.write("EXTRACFLAGS+=-I" + libraryFolder.getPath());
        makeFile.newLine();

        libMakeFile.write("include " + corePath + File.separator + "Rules.mak");
        libMakeFile.newLine();

        libMakeFile.close();

        makeFile.write("LIBS+="+libraryFolder.getName()+ File.separator + libraryName + ".a");
        makeFile.newLine();

        makeFile.write(libraryFolder.getName()+ File.separator + libraryName + ".a:");
        makeFile.newLine();
        makeFile.write("\t$(MAKE) -C " + libraryFolder.getName() + " " + libraryName + ".a");
        makeFile.newLine();

      }

      List<File> sketchSources = getAllSourcesInPath(buildPath,false);

      makeFile.write("TARGETOBJ=");
      for (File file : sketchSources) {
        makeFile.write( " " + Base.getFileNameWithoutExtension(file) + ".o ");
      }
      makeFile.newLine();

      // TODO: add targetobj dependencies

      makeFile.write("LIBS+=core/libcore.a");
      makeFile.newLine();

      makeFile.write("include " + corePath + File.separator + "Rules.mak");
      makeFile.newLine();

      makeFile.close();

    } catch (java.io.IOException e) {
      throw new RunnerException("Cannot write makefile!");
    }

    return runMake(avrBasePath, buildPath);
  }


  private boolean runMake(String avrBasePath,
                          String buildPath)
  throws RunnerException {

    
    List baseCommandMake = new ArrayList(Arrays.asList(new String[] {
      avrBasePath + "make", "--silent", "-C", buildPath, "all"}));

    execAsynchronously(baseCommandMake);
    return true;

  }

  boolean firstErrorFound;
  boolean secondErrorFound;

  /**
   * Either succeeds or throws a RunnerException fit for public consumption.
   */
  private void execAsynchronously(List commandList) throws RunnerException {
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
    
    try {
      process = Runtime.getRuntime().exec(command);
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
      RunnerException e = sketch.placeException(pieces[3], pieces[1], PApplet.parseInt(pieces[2]) - 1);

      // replace full file path with the name of the sketch tab (unless we're
      // in verbose mode, in which case don't modify the compiler output)
      if (e != null && !verbose) {
        SketchCode code = sketch.getCode(e.getCodeIndex());
        String fileName = code.isExtension(sketch.getDefaultExtension()) ? code.getPrettyName() : code.getFileName();
        s = fileName + ":" + e.getCodeLine() + ": error: " + e.getMessage();        
      }
      
      if (pieces[3].trim().equals("SPI.h: No such file or directory")) {
        e = new RunnerException("Please import the SPI library from the Sketch > Import Library menu.");
        s += "\nAs of Arduino 0019, the Ethernet library depends on the SPI library." +
             "\nYou appear to be using it or another library that depends on the SPI library.";
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
