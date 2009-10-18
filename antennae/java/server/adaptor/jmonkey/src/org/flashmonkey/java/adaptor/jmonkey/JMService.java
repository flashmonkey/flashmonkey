package org.flashmonkey.java.adaptor.jmonkey;

import org.flashmonkey.java.scene.api.IScene;
import org.flashmonkey.java.service.SimpleService;

/**
 * Extends the SimpleService class to provide an adaptor for a JMonkey scene.
 * 
 * @author Trevor
 *
 */
public class JMService extends SimpleService {
	
	IScene scene = new JMScene();
	
	public JMService() {
		
	}
}
