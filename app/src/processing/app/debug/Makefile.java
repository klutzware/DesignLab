/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Copyright (c) 2010 Alvaro Lopes

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
import processing.core.*;

import java.io.*;
import java.util.*;

public class Makefile extends BufferedWriter {

  private File location;

  /**
   * Create a new Makefile
   *
   * @param target File representing the Makefile to create
   * @return Newly constructed object
   * @throws IOException If anything goes wrong
   */
  public Makefile(File target) throws IOException {
    super( new FileWriter( target ) );
    location = target;
  }

  /**
   * Append an "include" directive. The include will always use an absolute path
   *
   * @param target File representing the file/Makefile to include
   * @throws IOException If anything goes wrong
   */
  public void include(String target) throws IOException {
    include(new File(target));
  }

  /**
   * Append an "include" directive for another Makefule. The include will always use an absolute path
   *
   * @param target Makefile to include
   * @throws IOException If anything goes wrong
   */
  public void include(Makefile target) throws IOException {
    include( target.getLocation() );
  }

  /**
   * Append an "include" file. The include will always use an absolute path
   *
   * @param target File to include
   * @throws IOException If anything goes wrong
   */
  public void include(File target) throws IOException {
    writeline("include " + target.getAbsolutePath() );
  }

  /**
   * Return the location of this Makefile
   *
   * @return  File representing this Makefile location
   */
  public File getLocation() {
    return location;
  }

  /**
   * Write a string to the Makefile, and append a new-line
   *
   * @param text String to write to Makefile.
   * @throws IOException If anything goes wrong
   */
  public void writeline(String text) throws IOException {
    write(text);
    newLine();
  }

  /**
   * Make an Object File from a Source File. Means - replace extension
   * with object extension.
   *
   * @param source File depicting source file
   * @return File depicting object file
   */
  public static File makeObjectFromSource(File source) {
    return new File(Base.getFileNameWithoutExtension(source) + ".o");
  }

  /**
   * Make an Object File List from a Source File List. Means - replace
   * extension with object extension for all source files.
   *
   * @param sources List<File> depicting source files
   * @return List<File> depicting object files
   */
  public static List<File> makeObjectsFromSources(List<File> sources) throws IOException {
    List<File> ret = new ArrayList<File>();

    for(File source: sources) {
      ret.add( makeObjectFromSource(source) );
    }
    return ret;
  }

  /**
   * Convert a variable name into anything suitable to use in a Makefile.
   *
   * @param name The variable's name
   * @return The new Makefile-safe variable name
   */
  public static String makeVariable(String name) {
    name = name.replace(".","___");
    return name;
  }

  public static String makeList(List<String> values) {
    String ret = null;
    for (String v: values) {
      if (null!=ret)
        ret+=" ";
      else
        ret = new String();
      ret+=v;
    }
    return ret;
  }

  public static String makeFileList(List<File> values) {
    String ret = null;
    for (File v: values) {
      if (null!=ret)
        ret+=" ";
      else
        ret = new String();
      ret+=v.getName();
    }
    return ret;
  }

  private void setVariableExtended(String name, String operator, String value) throws IOException {
    writeline(name + operator + value );
  }

  /**
   * Set a variable on Makefile
   *
   * @param name Name of variable
   * @param vakue Value to associate with that variable
   * @throws IOException If anything goes wrong
   */
  public void setVariable(String name, String value) throws IOException {
    setVariableExtended(name, "=", value);
  }

  /**
   * Set a variable on Makefile to a list of values
   *
   * @param name Name of variable
   * @param vakues List of values to associate with that variable
   * @throws IOException If anything goes wrong
   */
  public void setVariable(String name, List<String> values) throws IOException {
    setVariable(name, makeList(values) );
  }

  /**
   * Append a Makefile variable with a value
   *
   * @param name Name of variable
   * @param vakues Value to append to that variable
   * @throws IOException If anything goes wrong
   */
  public void appendVariable(String name, String value) throws IOException {
    setVariableExtended(name, "+=", value);
  }

  /**
   * Append a Makefile variable with a list of values
   *
   * @param name Name of variable
   * @param vakues List of values to append to that variable
   * @throws IOException If anything goes wrong
   */
  public void appendVariable(String name, List<String> values) throws IOException {
    appendVariable(name, makeList(values) );
  }

  /**
   * Add a dependency 
   *
   * @param target Target of dependency
   * @param dependency Dependency this target depends upon
   * @throws IOException If anything goes wrong
   */
  public void addDependency(File target, File dependency) throws IOException {
    write( target.getName() + ": ");
    writeline( dependency.getName() );
  }

  /**
   * Add a textual dependency
   *
   * @param target Target of dependency (string)
   * @param dependency Dependency this target depends upon
   * @throws IOException If anything goes wrong
   */
  public void addDependency(String target, String dependency) throws IOException {
    writeline ( target + ": "+ dependency );
  }

  /**
   * Add a dependency (list)
   *
   * @param target Target of dependency
   * @param dependency List of dependencies this target depends upon
   * @throws IOException If anything goes wrong
   */
  public void addDependency(File object, List<File> dependencies) throws IOException {
    write( object.getName() + ": ");
    writeline( makeFileList(dependencies) );
  }

  /**
   * Add a build rule for last inserted target
   *
   * @param rule Rule to build last target
   * @throws IOException If anything goes wrong
   */
  public void addBuildRule(String rule) throws IOException {
    writeline("\t" + rule );
  }
};
