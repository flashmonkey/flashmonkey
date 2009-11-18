package org.flashmonkey.examples.mousegesturecontrolvideo;

import java.util.Random;

public class Utils {

	private static Random generator = new Random();

	// returns a random float between zero and 1

	public static double randomDouble() {
		return generator.nextDouble();
	}

	public static double randomClamped() {
		return randomDouble() - randomDouble();
	}
}
