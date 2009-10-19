package org.red5.core;

import java.util.concurrent.Callable;

import com.jme.system.DisplaySystem;

public class Screenshot implements Callable<Object> {

	private String fileName;
	
	private DisplaySystem display;
	
	public Screenshot(DisplaySystem display, String fileName) {
		this.display = display;
		this.fileName = fileName;
	}
	
	public Object call() {
		System.out.println("Taking Screenshot: " + display + " " + fileName);
		
		display.getRenderer().takeScreenShot(fileName);
		
		return null;
	}
}
