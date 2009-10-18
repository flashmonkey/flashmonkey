package org.flashmonkey.java.avatar;

import org.flashmonkey.java.behaviour.NullBehaviour;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.input.SimpleInput;
import org.flashmonkey.java.input.api.IInput;

public class SimpleAvatar extends AbstractAvatar {
	
	public SimpleAvatar() {
		this(new SimpleInput(), new BasicState());
		
		behaviour = new NullBehaviour();
	}
	
	public SimpleAvatar(IInput input, BasicState state) {
		this.input = input;
		this.state = state;
	}
	
	@Override
	public void updateUserInput(int time, IInput input) {
		if (time > this.time) {
			this.time = time;
			this.input = input;
		}
	}	
	
	@Override 
	public void update() {
		time++;
		behaviour.update(time, input, state);
	}
}
