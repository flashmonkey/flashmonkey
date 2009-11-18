package org.flashmonkey.examples.mousegesturecontrolvideo;

import java.util.ArrayList;

public class NeuralNet implements Constants {
	// -------------------------------------------------------------------
	// define neuron struct
	// -------------------------------------------------------------------
	private class Neuron {
		// the number of inputs into the neuron
		public int m_iNumInputs;

		// the weights for each input
		public ArrayList<Double> m_vecWeight = new ArrayList<Double>();

		// the activation of this neuron
		public double m_dActivation;

		// the error value
		public double m_dError;

		// ctor
		public Neuron(int NumInputs) {

			m_iNumInputs = NumInputs + 1;
			m_dActivation = 0;
			m_dError = 0;
			// we need an additional weight for the bias hence the +1
			for (int i = 0; i < NumInputs + 1; ++i) {
				// set up the weights with an initial random value
				m_vecWeight.add(Utils.randomClamped());
			}
		}
	}

	// ---------------------------------------------------------------------
	// struct to hold a layer of neurons.
	// ---------------------------------------------------------------------
	private class NeuronLayer {
		// the number of neurons in this layer
		public int m_iNumNeurons;

		// the layer of neurons
		public ArrayList<Neuron> m_vecNeurons = new ArrayList<Neuron>();

		public NeuronLayer(int NumNeurons, int NumInputsPerNeuron) {

			m_iNumNeurons = NumNeurons;
			
			for (int i = 0; i < NumNeurons; ++i) {
				m_vecNeurons.add(new Neuron(NumInputsPerNeuron));
			}
		}
	}

	// ----------------------------------------------------------------------
	// neural net class
	// ----------------------------------------------------------------------
	private int m_iNumInputs;

	private int m_iNumOutputs;

	private int m_iNumHiddenLayers;

	private int m_iNeuronsPerHiddenLyr;

	// we must specify a learning rate for backprop
	private double m_dLearningRate;

	// cumulative error for the network (sum (outputs - expected))
	private double m_dErrorSum;

	// true if the network has been trained
	private boolean m_bTrained;

	// epoch counter
	private int m_iNumEpochs;

	// storage for each layer of neurons including the output layer
	private ArrayList<NeuronLayer> m_vecLayers = new ArrayList<NeuronLayer>();

	// given a training set this method performs one iteration of the
	// backpropagation algorithm. The training sets comprise of series
	// of vector inputs and a series of expected vector outputs. Returns
	// false if there is a problem.
	private boolean networkTrainingEpoch(ArrayList<ArrayList<Double>> SetIn,
			ArrayList<ArrayList<Double>> SetOut) {

		// create some iterators
		// vector<double>::iterator curWeight;
		double curWeight;
		// vector<SNeuron>::iterator curNrnOut, curNrnHid;
		Neuron curNrnOut, curNrnHid;
		// this will hold the cumulative error value for the training set
		m_dErrorSum = 0;
		// run each input pattern through the network, calculate the errors and
		// update
		// the weights accordingly
		for (int vec = 0; vec < SetIn.size(); vec++) {
			
			// first run this input vector through the network and retrieve the
			// outputs
			ArrayList<Double> outputs = Update(SetIn.get(vec));
			
			// return if error has occurred
			if (outputs.size() == 0) {
				return false;
			}
			
			// for each output neuron calculate the error and adjust weights
			// accordingly
			for (int op = 0; op < m_iNumOutputs; op++) {
				// first calculate the error value
				double err = (SetOut.get(vec).get(op) - outputs.get(op))
						* outputs.get(op) * (1 - outputs.get(op));
				
				// keep a record of the error value
				m_vecLayers.get(1).m_vecNeurons.get(op).m_dError = err;
				// update the SSE. (when this value becomes lower than a
				// preset threshold we know the training is successful)
				m_dErrorSum += (SetOut.get(vec).get(op) - outputs.get(op))
						* (SetOut.get(vec).get(op) - outputs.get(op));

				// for each weight up to but not including the bias

				ArrayList<Double> weights = m_vecLayers.get(1).m_vecNeurons
						.get(op).m_vecWeight;
				
				ArrayList<Neuron> hiddenNeurons = m_vecLayers.get(0).m_vecNeurons;
				
				for (int w = 0; w < weights.size() - 1; w++) {
					// calculate the new weight based on the backprop rules
					curWeight = weights.get(w);
					curNrnHid = hiddenNeurons.get(w);
					weights.set(w, curWeight + err * m_dLearningRate
							* curNrnHid.m_dActivation);
					// ++curWeight; ++curNrnHid;
				}
				
				// and the bias for this neuron
				curWeight = weights.get(weights.size() - 1);
				
				weights.set(weights.size() - 1, curWeight + err
						* m_dLearningRate * BIAS);
			}
			// **moving backwards to the hidden layer**
			int n = 0;
			
			// for each neuron in the hidden layer calculate the error signal
			// and then adjust the weights accordingly
			ArrayList<Neuron> hiddenNeurons = m_vecLayers.get(0).m_vecNeurons;
			
			for (int hn = 0; hn < hiddenNeurons.size(); hn++) {
				double err = 0;
				curNrnHid = hiddenNeurons.get(hn);

				// to calculate the error for this neuron we need to iterate
				// through
				// all the neurons in the output layer it is connected to and
				// sum
				// the error * weights
				ArrayList<Neuron> outputNeurons = m_vecLayers.get(1).m_vecNeurons;
				
				for (int on = 0; on < outputNeurons.size(); on++) {
					curNrnOut = outputNeurons.get(on);
					err += curNrnOut.m_dError * curNrnOut.m_vecWeight.get(n);
					// ++curNrnOut;
				}
				// now we can calculate the error
				err *= curNrnHid.m_dActivation * (1 - curNrnHid.m_dActivation);
				// for each weight in this neuron calculate the new weight based
				// on the error signal and the learning rate
				for (int w = 0; w < m_iNumInputs; ++w) {
					// calculate the new weight based on the backprop rules
					double weight = curNrnHid.m_vecWeight.get(w) + err
							* m_dLearningRate * SetIn.get(vec).get(w);
					curNrnHid.m_vecWeight.set(w, weight);
				}
				// and the bias
				double bias = curNrnHid.m_vecWeight.get(m_iNumInputs) + err
						* m_dLearningRate * BIAS;
				curNrnHid.m_vecWeight.set(m_iNumInputs, bias);
				// ++curNrnHid;
				n++;
			}
		}// next input vector
		return true;
	}

	private void CreateNet() {

		// create the layers of the network
		if (m_iNumHiddenLayers > 0) {
			// create first hidden layer
			m_vecLayers.add(new NeuronLayer(m_iNeuronsPerHiddenLyr,
					m_iNumInputs));
			for (int i = 0; i < m_iNumHiddenLayers - 1; i++) {
				m_vecLayers.add(new NeuronLayer(m_iNeuronsPerHiddenLyr,
						m_iNeuronsPerHiddenLyr));
			}
			// create output layer
			m_vecLayers.add(new NeuronLayer(m_iNumOutputs,
					m_iNeuronsPerHiddenLyr));
		} else {
			// create output layer
			m_vecLayers.add(new NeuronLayer(m_iNumOutputs, m_iNumInputs));
		}
	}

	// sets all the weights to small random values
	private void initializeNetwork() {

		// for each layer
		for (int i = 0; i < m_iNumHiddenLayers + 1; ++i) {
			// for each neuron
			for (int n = 0; n < m_vecLayers.get(i).m_iNumNeurons; ++n) {
				// for each weight
				for (int k = 0; k < m_vecLayers.get(i).m_vecNeurons.get(n).m_iNumInputs; ++k) {
					m_vecLayers.get(i).m_vecNeurons.get(n).m_vecWeight.set(k,
							Utils.randomClamped());
				}
			}
		}
		m_dErrorSum = 9999;
		m_iNumEpochs = 0;
		return;
	}

	// sigmoid response curve
	private double Sigmoid(double activation, double response) {

		return (1 / (1 + Math.exp(-activation / response)));
	}

	public NeuralNet(int NumInputs, int NumOutputs, int HiddenNeurons,
			double LearningRate) {

		m_iNumInputs = NumInputs;
		m_iNumOutputs = NumOutputs;
		m_iNumHiddenLayers = 1;
		m_iNeuronsPerHiddenLyr = HiddenNeurons;
		m_dLearningRate = LearningRate;
		m_dErrorSum = 9999;
		m_bTrained = false;
		m_iNumEpochs = 0;
		CreateNet();
	}

	// calculates the outputs from a set of inputs
	public ArrayList<Double> Update(ArrayList<Double> inputs) {

		// stores the resultant outputs from each layer
		System.out.println("inputs " + inputs.size());
		
		ArrayList<Double> outputs = new ArrayList<Double>();
		
		int cWeight = 0;
		// first check that we have the correct amount of inputs
		if (inputs.size() != m_iNumInputs) {
			// just return an empty vector if incorrect.
			return outputs;
		}
		// For each layer...
		for (int i = 0; i < m_iNumHiddenLayers + 1; ++i) {
			
			if (i > 0) {
				inputs = (ArrayList<Double>) outputs.clone();
			}
			
			outputs.clear();
			
			cWeight = 0;
			
			// for each neuron sum the (inputs * corresponding weights).Throw
			// the total at our sigmoid function to get the output.
			for (int n = 0; n < m_vecLayers.get(i).m_iNumNeurons; ++n) {
				
				double netinput = 0;
				
				int NumInputs = m_vecLayers.get(i).m_vecNeurons.get(n).m_iNumInputs;
				
				// for each weight
				for (int k = 0; k < NumInputs - 1; ++k) {
					// sum the weights x inputs
					netinput += m_vecLayers.get(i).m_vecNeurons.get(n).m_vecWeight
							.get(k)
							* inputs.get(cWeight++);
				}
				
				// add in the bias
				netinput += m_vecLayers.get(i).m_vecNeurons.get(n).m_vecWeight
						.get(NumInputs - 1)
						* BIAS;
				
				// The combined activation is first filtered through the sigmoid
				// function and a record is kept for each neuron
				m_vecLayers.get(i).m_vecNeurons.get(n).m_dActivation = Sigmoid(
						netinput, ACTIVATION_RESPONSE);
				
				// store the outputs from each layer as we generate them.
				outputs
						.add(m_vecLayers.get(i).m_vecNeurons.get(n).m_dActivation);
				cWeight = 0;
			}
		}
		return outputs;
	}

	// trains the network given a training set. Returns false if
	// there is an error with the data sets
	public boolean train(Data data) {

		ArrayList<ArrayList<Double>> setIn = data.GetInputSet();
		ArrayList<ArrayList<Double>> setOut = data.GetOutputSet();
		
		// first make sure the training set is valid
		if ((setIn.size() != setOut.size())
				|| (setIn.get(0).size() != m_iNumInputs)
				|| (setOut.get(0).size() != m_iNumOutputs)) {

			return false;
		}
		
		// initialize all the weights to small random values
		initializeNetwork();
		
		// train using backprop until the SSE is below the user defined
		// threshold
		while (m_dErrorSum > ERROR_THRESHOLD) {
			// return false if there are any problems
			if (!networkTrainingEpoch(setIn, setOut)) {
				return false;
			}
			
			m_iNumEpochs++;
		}
		m_bTrained = true;
		return true;
	}

	// accessor methods
	public boolean getTrained() {

		return m_bTrained;
	}

	public double getError() {

		return m_dErrorSum;
	}

	public int getEpoch() {

		return m_iNumEpochs;
	}
}
