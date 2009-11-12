package org.red5.core;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 * 
 * Copyright (c) 2006-2007 by respective authors (see below). All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later 
 * version. 
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along 
 * with this library; if not, write to the Free Software Foundation, Inc., 
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.stream.IStreamAwareScopeHandler;

import edu.cmu.sphinx.decoder.ResultListener;
import edu.cmu.sphinx.frontend.util.AudioFileDataSource;
import edu.cmu.sphinx.recognizer.Recognizer;
import edu.cmu.sphinx.result.Result;
import edu.cmu.sphinx.util.props.ConfigurationManager;
import edu.cmu.sphinx.util.props.PropertyException;
import edu.cmu.sphinx.util.props.PropertySheet;

/**
 * Red5Server Framework.
 * 
 * @author The Red5 Project (red5@osflash.org)
 * @author Dominick Accattato
 * @author Joachim Bauch (jojo@struktur.de)
 */
public class Application extends ApplicationAdapter implements IStreamAwareScopeHandler, ResultListener {
	
	ConfigurationManager cm;
	
	
	public Application() {
		System.out.println("test");
		
		String configURL = System.getProperty("red5.root") + "/webapps/HelloSpeechRecognition/WEB-INF/config.xml";
		cm = new ConfigurationManager(configURL);
	}

	/** {@inheritDoc} */
	//@Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
		// Check if the user passed valid parameters.
		if (params == null || params.length == 0) {
			// NOTE: "rejectClient" terminates the execution of the current method!
			rejectClient("No username passed.");
		}

		// Call original method of parent class.
		if (!super.connect(conn, scope, params)) {
			return false;
		}

		String username = params[0].toString();
		String uid = conn.getClient().getId();
		
		// Notify client about unique id.
		ServiceUtils.invokeOnConnection(conn, "setClientID",
				new Object[] { uid });
		return true;
	}

	public String interpretSpeech(String stream) {
		
		//Duration: 00:00:02.87, bitrate: 256 kb/s
	    //Stream #0.0: Audio: pcm_s16le, 16000 Hz, 1 channels, s16, 256 kb/s

		System.out.println("Interpreting from stream " + stream);
		
		String path = System.getProperty("red5.root") + "/webapps/HelloSpeechRecognition/streams/";
        String srcPath = path + stream + ".flv";
        String destPath = path + stream + ".wav";

		
		try
        {            
            Runtime rt = Runtime.getRuntime();
            
            
            
            String cmd = "/usr/local/bin/ffmpeg -i " + srcPath + " " + destPath;
            
            Process proc = rt.exec(cmd);
            InputStream stderr = proc.getErrorStream();
            InputStreamReader isr = new InputStreamReader(stderr);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            //System.out.println("<ERROR>");
            while ( (line = br.readLine()) != null)  {
                System.out.println(line);
            }
            //System.out.println("</ERROR>");
            int exitVal = proc.waitFor();
            System.out.println("Process exitValue: " + exitVal);
            
            // look up the recognizer (which will also lookup all its dependencies
            Recognizer recognizer = (Recognizer) cm.lookup("recognizer");
            recognizer.allocate();

            // configure the audio input for the recognizer
            AudioFileDataSource dataSource = (AudioFileDataSource) cm.lookup("audioFileDataSource");
            dataSource.setAudioFile(new File(destPath), null);

            // decode the audio file.
            System.out.println("Decoding " + destPath);
            Result result = recognizer.recognize();

            System.out.println("Result: " + (result != null ? result.getBestFinalResultNoFiller() : null));
            
        } catch (Throwable t) {
            t.printStackTrace();
        }
		
		return "batter-like discharge";
	}

	@Override
	public void newResult(Result result) {
		System.out.println("RECEIVED RESULT: " + result.getBestFinalResultNoFiller());
		
	}

	@Override
	public void newProperties(PropertySheet arg0) throws PropertyException {
		// TODO Auto-generated method stub
		
	}


}
