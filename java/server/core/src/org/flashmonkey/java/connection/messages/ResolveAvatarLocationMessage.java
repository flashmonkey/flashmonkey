package org.flashmonkey.java.connection.messages;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class ResolveAvatarLocationMessage extends BaseMessage {
	
	private String id;
	
	public Object read() {
		return "model/trooper/trooper-helm-skin.xml";
	}
	
	//@Override 
	public void write() {
		
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		id = input.readUTF();
	}
	
	@Override 
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(id);
	}
}
