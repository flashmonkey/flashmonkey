package org.flashmonkey.java.examples.speechrecognition;

import edu.cmu.sphinx.recognizer.Recognizer;
import edu.cmu.sphinx.util.props.ConfigurationManager;


public interface ISpeechRecognitionService {

	public Recognizer getRecognizer();
	
	public ConfigurationManager getConfigurationManager();
}
