package org.flashmonkey.java.ai.statemachine.condition;

import org.flashmonkey.java.ai.statemachine.Condition;

public class StringMatchCondition implements Condition
{
	public String	watch;
	
	public String	target;
	
	public boolean test()
	{
		return watch.equals(target);
	}
	
}
