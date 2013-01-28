/* -*- mode: jde; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Sizer - computes the size of a .hex file
  Part of the Arduino project - http://www.arduino.cc/

  Copyright (c) 2006 David A. Mellis
  Copyright (c) 2010 Alvaro Lopes
  Copyright (c) 2011 Cristian Maglie <c.maglie@bug.st>

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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import processing.app.helpers.PreferencesMap;
import processing.app.helpers.StringReplacer;
import java.util.ArrayList;
import java.util.List;

public class Sizer {
  private String buildPath, sketchName;
  public Sizer(String buildPath, String sketchName) {
    this.buildPath = buildPath;
    this.sketchName = sketchName;
  }
  
  public List<Long> computeSize() throws RunnerException {

    // Size file should have been created by make

    String sizeFile = buildPath + File.separator + Base.getFileNameWithoutExtension(new File(sketchName)) + ".size";
    long size = -1;
    long data_size = -1;
    long bss_size = -1;
    long text_size = -1;

    try {
      BufferedReader fileReader = new BufferedReader(new FileReader(sizeFile));
      String sizeString = fileReader.readLine(); // This line is to be ignored
      sizeString = fileReader.readLine();
      fileReader.close();
      StringTokenizer st = new StringTokenizer(sizeString, " ");

      try {
        //    text    data     bss     dec     hex filename
	// 20364    1052    1512   22928    5990 /tmp/bu
	text_size = (new Integer(st.nextToken().trim())).longValue();
	data_size = (new Integer(st.nextToken().trim())).longValue(); // DEC
        bss_size = (new Integer(st.nextToken().trim())).longValue(); // DEC
        size = (new Integer(st.nextToken().trim())).longValue(); // DEC
      } catch (NoSuchElementException e) {
        throw new RunnerException(e.toString());
      } catch (NumberFormatException e) {
        throw new RunnerException(e.toString());
      }
      ArrayList<Long> ret = new ArrayList<Long>();

      ret.add( new Long(text_size) ); 
      ret.add( new Long(data_size) );
      ret.add( new Long(bss_size) );

      return ret;

    } catch (IOException e) {
      throw new RunnerException(e.toString());
    }
  }
}
