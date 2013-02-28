/* -*- mode: jde; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  ZPUinoUploader - uploader implementation for ZPUino

  Copyright (c) 2010
  Alvaro Lopes

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
import processing.app.Preferences;
import processing.app.Serial;
import processing.core.*;

import java.io.*;
import java.util.*;
import java.util.zip.*;
import javax.swing.*;
import gnu.io.*;


public class ZPUinoUploader extends Uploader  {
  public ZPUinoUploader() {
  }

  // XXX: add support for uploading sketches using a programmer
  public boolean uploadUsingPreferences(String buildPath, String className, int uploadOptions)
  throws RunnerException {
    this.verbose = verbose;
    Map<String, String> boardPreferences = Base.getBoardPreferences();
    String uploadUsing = boardPreferences.get("upload.using");
    if (uploadUsing == null) {
      // fall back on global preference
      uploadUsing = Preferences.get("upload.using");
    }

    if (uploadOptions == uploadUsingProgrammer ) {
        throw new RunnerException("ZPUino targets do not support upload using programmer");
    }

    if (uploadUsing.equals("bootloader")) {
      return uploadViaBootloader(buildPath, className, uploadOptions==uploadToMemory);
    } else {
      Target t;

      if (uploadUsing.indexOf(':') == -1) {
        t = Base.getTarget(); // the current target (associated with the board)
      } else {
        String targetName = uploadUsing.substring(0, uploadUsing.indexOf(':'));
        t = Base.targetsTable.get(targetName);
        uploadUsing = uploadUsing.substring(uploadUsing.indexOf(':') + 1);
      }

      Collection params = getProgrammerCommands(t, uploadUsing);

      params.add("-b" + buildPath + File.separator + Base.getFileNameWithoutExtension(new File(className)) + ".bin");
      return zpuinoprogrammer(params);
    }
  }
  
  private boolean uploadViaBootloader(String buildPath, String className, boolean toMemory)
  throws RunnerException {
    Map<String, String> boardPreferences = Base.getBoardPreferences();
    List commandDownloader = new ArrayList();

    String extraOptions = boardPreferences.get("upload.extraoptions");
    String speed = boardPreferences.get("upload.speed");
    if (speed!=null) {
        commandDownloader.add("-s");
        if (toMemory) {
            commandDownloader.add("115200");
        } else {
            commandDownloader.add(speed);
        }
    }
    commandDownloader.add(
      "-d" + (Base.isWindows() ? "\\\\.\\" : "") + Preferences.get("serial.port"));

    commandDownloader.add("-b" + buildPath + File.separator + Base.getFileNameWithoutExtension(new File(className)) + ".bin");
    commandDownloader.add("-R"); // Reset
    if (toMemory)
        commandDownloader.add("-U");

    // Append extra data file, if present
    File smallfs = new File(buildPath,"smallfs.dat");
    if (smallfs.exists()) {
        
        if (toMemory) {
            // Just warn user
            System.err.println("SmallFS filesystem found, *NOT* programming FLASH because you're doing a memory upload");
        } else {
            System.out.println("SmallFS filesystem found, appending extra data file to FLASH");
            commandDownloader.add("-e");
            commandDownloader.add(smallfs.getPath());
        }
    }

    if (extraOptions!=null) {
        for (String i: PApplet.split(extraOptions," ")) {
            commandDownloader.add(i);
        }
    }
    return zpuinoprogrammer(commandDownloader);
  }
  
  public boolean burnBootloader(String targetName, String programmer) throws RunnerException {
    return burnBootloader(getProgrammerCommands(Base.targetsTable.get(targetName), programmer));
  }

  public boolean burnBootloader() throws RunnerException {
      throw new RunnerException("Not supported!");
  }

  private Collection getProgrammerCommands(Target target, String programmer) {
    Map<String, String> programmerPreferences = target.getProgrammers().get(programmer);
    List params = new ArrayList();
    params.add("-c" + programmerPreferences.get("protocol"));
    
    if ("usb".equals(programmerPreferences.get("communication"))) {
      params.add("-Pusb");
    } else if ("serial".equals(programmerPreferences.get("communication"))) {
      params.add("-P" + (Base.isWindows() ? "\\\\.\\" : "") + Preferences.get("serial.port"));
      if (programmerPreferences.get("speed") != null) {
	params.add("-b" + Integer.parseInt(programmerPreferences.get("speed")));
      }
    }
    // XXX: add support for specifying the port address for parallel
    // programmers, although avrdude has a default that works in most cases.
    
    if (programmerPreferences.get("force") != null &&
        programmerPreferences.get("force").toLowerCase().equals("true"))
      params.add("-F");
    
    if (programmerPreferences.get("delay") != null)
      params.add("-i" + programmerPreferences.get("delay"));
    
    return params;
  }
  
  protected boolean burnBootloader(Collection params)
    throws RunnerException {
      return false;
  }
  
  public boolean zpuinoprogrammer(Collection p1, Collection p2) throws RunnerException {
    ArrayList p = new ArrayList(p1);
    p.addAll(p2);
    return zpuinoprogrammer(p);
  }
  
  public boolean zpuinoprogrammer(Collection params) throws RunnerException {
    List commandDownloader = new ArrayList();
    if (Base.isLinux() || Base.isMacOS()) {
        commandDownloader.add("zpuinoprogrammer");
    } else {
        commandDownloader.add("zpuinoprogrammer.exe");
    }
    commandDownloader.addAll(params);

    return executeUploadCommand(commandDownloader);
  }
}
