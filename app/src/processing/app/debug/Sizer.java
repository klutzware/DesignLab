/* -*- mode: jde; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Sizer - computes the size of a .hex file
  Part of the Arduino project - http://www.arduino.cc/

  Copyright (c) 2006 David A. Mellis
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
  
  $Id$
*/

package processing.app.debug;

import processing.app.Base;

import java.io.*;
import java.util.*;

public class Sizer {
  private String buildPath, sketchName;
  public Sizer(String buildPath, String sketchName) {
    this.buildPath = buildPath;
    this.sketchName = sketchName;
  }
  
  public long computeSize() throws RunnerException {

    // Size file should have been created by make

    String sizeFile = buildPath + File.separator + Base.getFileNameWithoutExtension(new File(sketchName)) + ".size";
    long size = -1;

    try {
      BufferedReader fileReader = new BufferedReader(new FileReader(sizeFile));
      String sizeString = fileReader.readLine(); // This line is to be ignored
      sizeString = fileReader.readLine();
      fileReader.close();
      StringTokenizer st = new StringTokenizer(sizeString, " ");

      try {
        st.nextToken();
        st.nextToken();
        st.nextToken();
        size = (new Integer(st.nextToken().trim())).longValue();
      } catch (NoSuchElementException e) {
        throw new RunnerException(e.toString());
      } catch (NumberFormatException e) {
        throw new RunnerException(e.toString());
      }

      return size;
    } catch (IOException e) {
      throw new RunnerException(e.toString());
    }
  }
}
