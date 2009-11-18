package org.flashmonkey.java.examples.speechrecognition;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.flashmonkey.java.connection.messages.AbstractMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import edu.cmu.sphinx.frontend.util.AudioFileDataSource;
import edu.cmu.sphinx.result.Result;

public class SpeechRecognitionMessage extends AbstractMessage {

	protected ISpeechRecognitionService service;
	
	protected String streamName;
	
	protected String bestResult;
	
	public Object read() {
		//Duration: 00:00:02.87, bitrate: 256 kb/s
	    //Stream #0.0: Audio: pcm_s16le, 16000 Hz, 1 channels, s16, 256 kb/s

		System.out.println("Interpreting from stream " + streamName);
		
		String path = System.getProperty("red5.root") + "/webapps/HelloSpeechRecognition/streams/";
        String srcPath = path + streamName + ".flv";
        String destPath = path + streamName + ".wav";

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
            
            // configure the audio input for the recognizer
            AudioFileDataSource dataSource = (AudioFileDataSource) service.getConfigurationManager().lookup("audioFileDataSource");
            dataSource.setAudioFile(new File(destPath), null);

            // decode the audio file.
            System.out.println("Decoding " + destPath);
            Result result = service.getRecognizer().recognize();
            
            if (!result.equals(null)) {
            	bestResult = result.getBestFinalResultNoFiller();
            	
            	System.out.println("Result: " + bestResult);
            	
            	return this;
            }
        } catch (Throwable t) {
            t.printStackTrace();
        }
        
		return null;
	}
	
	public void write() {
		
	}
	
	public void readExternal(IDataInput input) {
		System.out.println("Reading External");
		super.readExternal(input);
		
		streamName = input.readUTF();
		bestResult = input.readUTF();
	}
	
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		System.out.println("Writing " + streamName + " " + bestResult);
		output.writeUTF(streamName);
		output.writeUTF(bestResult);
	}
	
	public void setService(Object service) {
		if (service instanceof ISpeechRecognitionService) {
			this.service = (ISpeechRecognitionService)service;
		}
	}
	
	public String getStreamName() {
		return streamName;
	}
	
	public void setStreamName(String streamName) {
		this.streamName = streamName;
	}
	
	public String getBestResult() {
		return bestResult;
	}
	
	public void setBestResult(String bestResult) {
		this.bestResult = bestResult;
	}
}
