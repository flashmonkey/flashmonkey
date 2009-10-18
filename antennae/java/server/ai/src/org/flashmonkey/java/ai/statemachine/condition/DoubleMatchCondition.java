package org.flashmonkey.java.ai.statemachine.condition;

import org.flashmonkey.java.ai.statemachine.Condition;

public class DoubleMatchCondition implements Condition
{
	public double watch;
	
	public double target;
	
	public boolean test()
	{
		return watch == target;
	}
	
}
