package org.flashmonkey.examples.mousegesturecontrolvideo.messages;

import java.util.ArrayList;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class RecogniseGestureMessage extends BaseGestureMessage {
	
	protected ArrayList<Double> gesture;// = new ArrayList<Double>();
	
	public RecogniseGestureMessage() {
		
	}
	
	public void write() {
		
	}
	
	public Object read() {
		System.out.println("Service " + service);
		System.out.println("result: " + service.getController().TestForMatch(gesture));
		if (service.getController().TestForMatch(gesture)) {
			return service.getController().getBestMatchName();
		}
		return "no match";
	}

	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		int n = input.readInt();
		gesture = new ArrayList<Double>();
		System.out.println(n + " entries in array");
		for (int i = 0; i < n; i++) {
			gesture.add(input.readDouble());
		}
	}

	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
	}

}
