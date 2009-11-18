package org.flashmonkey.examples.mousegesturecontrolvideo;

import java.util.ArrayList;

public class Controller implements Constants {

	// the neural network
	private NeuralNet m_pNet;

	// this class holds all the training data
	private Data m_pData;

	// the user mouse gesture paths - raw and smoothed
	private ArrayList<Point> m_vecPath;

	private ArrayList<Point> m_vecSmoothPath;

	// the smoothed path transformed into vectors
	private ArrayList<Double> m_vecVectors;

	// the highest output the net produces. This is the most
	// likely candidate for a matched gesture.
	private double m_dHighestOutput;

	// the best match for a gesture based on m_dHighestOutput
	private int m_iBestMatch;

	// if the network has found a pattern this is the match
	private int m_iMatch;

	// the raw mouse data is smoothed to this number of points
	private int m_iNumSmoothPoints;

	// the number of patterns in the database;
	private int m_iNumValidPatterns;

	// the current state of the program
	private Mode m_Mode;

	// clears the mouse data vectors
	private void Clear() {

		m_vecPath.clear();

		m_vecSmoothPath.clear();

		m_vecVectors.clear();
	}

	// given a series of points whis method creates a path of
	// normalized vectors
	private void CreateVectors() {

		for (int p = 1; p < m_vecSmoothPath.size(); ++p) {
			double x = m_vecSmoothPath.get(p).x - m_vecSmoothPath.get(p - 1).x;
			double y = m_vecSmoothPath.get(p).y - m_vecSmoothPath.get(p - 1).y;

			Vector2D v1 = new Vector2D(1, 0);
			Vector2D v2 = new Vector2D(x, y);

			v2.normalize();

			m_vecVectors.add(v2.x);
			m_vecVectors.add(v2.y);
		}
	}

	// preprocesses the mouse data into a fixed number of points

	private boolean Smooth() {

		// make sure it contains enough points for us to work with
		if (m_vecPath.size() < m_iNumSmoothPoints) {
			// return
			return false;
		}

		// copy the raw mouse data
		m_vecSmoothPath = m_vecPath;

		// while there are excess points iterate through the points
		// finding the shortest spans, creating a new point in its place
		// and deleting the adjacent points.
		while (m_vecSmoothPath.size() > m_iNumSmoothPoints) {
			double ShortestSoFar = 99999999;

			int PointMarker = 0;

			// calculate the shortest span
			for (int SpanFront = 2; SpanFront < m_vecSmoothPath.size() - 1; ++SpanFront) {
				// calculate the distance between these points
				double length = Math
						.sqrt((m_vecSmoothPath.get(SpanFront - 1).x - m_vecSmoothPath
								.get(SpanFront).x)
								* (m_vecSmoothPath.get(SpanFront - 1).x - m_vecSmoothPath
										.get(SpanFront).x)
								+ (m_vecSmoothPath.get(SpanFront - 1).y - m_vecSmoothPath
										.get(SpanFront).y)
								* (m_vecSmoothPath.get(SpanFront - 1).y - m_vecSmoothPath
										.get(SpanFront).y));

				if (length < ShortestSoFar) {
					ShortestSoFar = length;
					PointMarker = SpanFront;
				}
			}

			// now the shortest span has been found calculate a new point in the
			// middle of the span and delete the two end points of the span
			Point newPoint = new Point();

			newPoint.x = (m_vecSmoothPath.get(PointMarker - 1).x +

			m_vecSmoothPath.get(PointMarker).x) / 2;

			newPoint.y = (m_vecSmoothPath.get(PointMarker - 1).y +

			m_vecSmoothPath.get(PointMarker).y) / 2;

			m_vecSmoothPath.set(PointMarker - 1, newPoint);

			m_vecSmoothPath.remove(PointMarker);
		}
		return true;
	}

	// tests for a match with a prelearnt gesture

	public boolean TestForMatch(ArrayList<Double> gesture) {

		// input the smoothed mouse vectors into the net and see if we get a
		// match
		m_vecVectors = gesture;

		ArrayList<Double> outputs = m_pNet.Update(m_vecVectors);

		if (outputs.size() == 0) {
			return false;
		}

		// run through the outputs and see which is highest
		m_dHighestOutput = 0;

		m_iBestMatch = 0;

		m_iMatch = -1;

		for (int i = 0; i < outputs.size(); ++i) {
			if (outputs.get(i) > m_dHighestOutput) {
				// make a note of the most likely candidate
				m_dHighestOutput = outputs.get(i);
				m_iBestMatch = i;

				// if the candidates output exceeds the threshold we
				// have a match! ...so make a note of it.
				if (m_dHighestOutput > MATCH_TOLERANCE) {
					m_iMatch = m_iBestMatch;
				}
			}
		}

		return true;
	}

	public String getBestMatchName() {

		return m_pData.PatternName(m_iBestMatch);
	}

	// this temporarily holds any newly created pattern names
	private static String m_sPatternName;

	public Controller() {

		m_iNumSmoothPoints = NUM_VECTORS + 1;

		m_dHighestOutput = 0;

		m_iBestMatch = -1;

		m_iMatch = -1;

		m_iNumValidPatterns = NUM_PATTERNS;

		m_Mode = Mode.UNREADY;

		// create the database

		m_pData = new Data(m_iNumValidPatterns, NUM_VECTORS);

		// setup the network

		m_pNet = new NeuralNet(NUM_VECTORS * 2,

		m_iNumValidPatterns,

		NUM_HIDDEN_NEURONS,

		LEARNING_RATE);
	}

	public boolean TrainNetwork() {

		m_Mode = Mode.TRAINING;

		if (!m_pNet.train(m_pData)) {
			return false;
		}

		System.out.println("Network trained");

		m_Mode = Mode.ACTIVE;

		return true;
	}

	public void LearningMode() {

		m_Mode = Mode.LEARNING;

		Clear();
	}

	public void learnNewGesture(String name, ArrayList<Double> gesture) {

		m_pData.AddData(gesture, name);

		m_iNumValidPatterns++;

		// create a new network
		m_pNet = new NeuralNet(NUM_VECTORS * 2, m_iNumValidPatterns,
				NUM_VECTORS * 2, LEARNING_RATE);

		// train the network
		TrainNetwork();
	}

	// call this to add a point to the mouse path

	void AddPoint(Point p) {

		m_vecPath.add(p);
	}
}
