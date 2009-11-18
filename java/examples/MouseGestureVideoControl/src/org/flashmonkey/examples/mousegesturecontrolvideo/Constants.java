package org.flashmonkey.examples.mousegesturecontrolvideo;

public interface Constants {

	// -----------------------------------------------
	// used in CData/CMouse
	// -----------------------------------------------

	// total number of built in patterns
	public final int NUM_PATTERNS = 11;

	// how much the input data is perturbed by to make
	// additional training sets
	public final double MAX_NOISE_TO_ADD = 0.1;

	// how many vectors each pattern contains
	public final int NUM_VECTORS = 12;

	// output has to be above this value for the program
	// to agree on a pattern. Below this value and it
	// will try to guess the pattern
	public final double MATCH_TOLERANCE = 0.98;

	// -----------------------------------------------
	// used in CNeuralNet
	// -----------------------------------------------
	public final double ACTIVATION_RESPONSE = 1.0;
	public final int BIAS = -1;

	// the learning rate for the backprop.
	public final int LEARNING_RATE = 2;

	// when the total error is below this value the
	// backprop stops training
	public final double ERROR_THRESHOLD = 0.05;

	public final int NUM_HIDDEN_NEURONS = 6;

	public final double MOMENTUM = 0.9;
}
