package org.flashmonkey.examples.mousegesturecontrolvideo;

import java.util.ArrayList;

public class Data implements Constants {

	private double[][] InputVectors =

	{

			{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
					1, 0 }, // right

			{ -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0,
					-1, 0, -1, 0, -1, 0 }, // left

			{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1,
					0, 1 }, // down

			{ 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0,
					-1, 0, -1, 0, -1 }, // up

			{ 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, -1, 0, -1, 0, -1, 0, 0, -1,
					0, -1, 0, -1 }, // clockwise square

			{ -1, 0, -1, 0, -1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, -1,
					0, -1, 0, -1 }, // anticlockwise square

			{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, -0.45, 0.9,
					-0.9, 0.45, -0.9, 0.45 }, // Right Arrow

			{ -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0,
					0.45, 0.9, 0.9, 0.45, 0.9, 0.45 }, // Left Arrow

			{ -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7,            

						  -0.7,0.7, -0.7,0.7, -0.7,0.7, -0.7,0.7 },

			{ 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7, 0.7,0.7,        

							  0.7,0.7, 0.7,0.7, 0.7,0.7 },

			{ 1, 0, 1, 0, 1, 0, 1, 0, -0.72, 0.69, -0.7, 0.72, 0.59, 0.81, 1,
					0, 1, 0, 1, 0, 1, 0, 1, 0 } // zorro

	};

	private String[] Names =

	{

	"Right",

	"Left",

	"Down",

	"Up",

	"Clockwise Square",

	"Anti-Clockwise Square",

	"Right Arrow",

	"Left Arrow",

	"South West",

	"South East",

	"Zorro"

	};

	// these will contain the training set when created.

	private ArrayList<ArrayList<Double>> m_SetIn = new ArrayList<ArrayList<Double>>();

	private ArrayList<ArrayList<Double>> m_SetOut = new ArrayList<ArrayList<Double>>();

	// the names of the gestures

	private ArrayList<String> m_vecNames = new ArrayList<String>();

	// the vectors which make up the gestures

	private ArrayList<ArrayList<Double>> m_vecPatterns = new ArrayList<ArrayList<Double>>();

	// number of patterns loaded into database

	private int m_iNumPatterns = 0;

	// size of the pattern vector

	private int m_iVectorSize = 0;

	// adds the predefined patterns and names to m_vecNames

	// and m_vecPatterns

	private void Init() {
		// for each const pattern

		for (int ptn = 0; ptn < m_iNumPatterns; ++ptn)

		{

			// add it to the vector of patterns

			ArrayList<Double> temp = new ArrayList<Double>();

			for (int v = 0; v < m_iVectorSize * 2; ++v)

			{

				temp.add(InputVectors[ptn][v]);

			}

			m_vecPatterns.add(temp);

			// add the name of the pattern

			m_vecNames.add(Names[ptn]);

		}
	}

	public Data(int NumStartPatterns,

	int VectorSize)

	{

		m_iNumPatterns = NumStartPatterns;

		m_iVectorSize = VectorSize;

		Init();

		CreateTrainingSetFromData();

	}

	// returns the name of the pattern at val

	public String PatternName(int val) {
		if (m_vecNames.size() > 0)

		{

			return m_vecNames.get(val);

		}

		else

		{

			return "";

		}
	}

	// this adds a new pattern and pattern name to the training data.

	// In addition, the function automatically adds the correct amount

	// of dirty versions of the pattern

	public boolean AddData(ArrayList<Double> data, String NewName) {
		// check that the size is correct

		if (data.size() != m_iVectorSize * 2)

		{

			// MessageBox(NULL, "Incorrect Data Size", "Error", MB_OK);

			return false;

		}

		// add the name

		m_vecNames.add(NewName);

		// add the data

		m_vecPatterns.add(data);

		// keep a track of number of patterns

		m_iNumPatterns++;

		// create the new training set

		CreateTrainingSetFromData();

		return true;
	}

	// this function creates a training set from the data defined as

	// constants in CData.h. From each pattern several additional patterns

	// are formed by adding random noise

	public void CreateTrainingSetFromData() {
		// empty the vectors

		m_SetIn.clear();

		m_SetOut.clear();

		// add each pattern

		for (int ptn = 0; ptn < m_iNumPatterns; ++ptn)

		{

			// add the data to the training set

			m_SetIn.add(m_vecPatterns.get(ptn));

			// create the output vector for this pattern. First fill a

			// std::vector with zeros

			// ArrayList<Double> outputs(m_iNumPatterns, 0);
			ArrayList<Double> outputs = new ArrayList<Double>();

			for (int i = 0; i < m_iNumPatterns; i++) {
				outputs.add(0.0);
			}

			// set the relevant output to 1

			outputs.set(ptn, 1.0);

			// add it to the output set

			m_SetOut.add(outputs);

		}
	}

	public ArrayList<ArrayList<Double>> GetInputSet() {
		return m_SetIn;
	}

	public ArrayList<ArrayList<Double>> GetOutputSet() {
		return m_SetOut;
	}
}
