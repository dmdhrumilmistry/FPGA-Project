from numpy import average, exp, array, random, dot
import matplotlib.pyplot as plt
import pickle
import os



class NeuralNetwork:
    def __init__(self, inputs:array, outputs:array, tot_epochs:int=30000, save_weights:bool=True, trained:bool=False) -> None:
        random.seed(1)
        self.inputs = inputs
        self.outputs = outputs
        self.trained = trained
        self.save_weights = save_weights
        self.tot_epochs = tot_epochs
        self.error_list = []
        self.epochs_list = []

        if self.trained:
            with open(os.path.join(os.getcwd(), 'weights.trained'), 'rb') as f:
                self.w_mat = array(pickle.loads(f.read()))
        else:
            self.w_mat = 2 * random.random((3,1)) - 1

        print("[*] Initial weights: ")
        print(self.w_mat)


    def sigmoid(self, x):
        return 1 / (1 + exp(-x))


    def sigmoid_derivative(self, x):
        sx = self.sigmoid(x)
        return sx * (1 - sx)


    def feed_forward(self):
        self.__hidden = self.sigmoid(dot(self.inputs, self.w_mat))


    def backpropogation(self):
        self.__error = self.outputs - self.__hidden
        delta = self.__error * self.sigmoid_derivative(self.__hidden)
        self.w_mat += dot(self.inputs.T, delta)


    def train(self):
        for epoch in range(self.tot_epochs):
            self.feed_forward()
            self.backpropogation()
            self.error_list.append(average(abs(self.__error)))
            self.epochs_list.append(epoch)
        print("[*] Weights after training:")
        print(self.w_mat)
        if self.save_weights:
            with open(os.path.join(os.getcwd(), 'weights.trained'), 'wb') as f:
                f.write(pickle.dumps(self.w_mat))

        self.trained = True


    def predict(self, inputs):
        if self.trained:
            return self.sigmoid(dot(inputs, self.w_mat))
        print("[Error] Model not trained.")
        return array()


if __name__ == '__main__':
    # init inputs and outputs array
    inputs = array([
        [0,1,1], # 0
        [1,0,0], # 1
        [0,1,1], # 0
        [1,1,1], # 1
        [1,0,1], # 1
        [0,0,1], # 0
    ])

    outputs = array([
        [0],
        [1],
        [0],
        [1],
        [1],
        [0],
    ])

    # Create newtork
    training_status = False
    network = NeuralNetwork(inputs, outputs, 10000, trained=training_status)
    network.train()

    # Create tests
    test1 = array([[1,1,0]])
    test2 = array([[0,1,0]])

    # Predict values
    print(f"[*] Predicted Output for {test1} input, expected output {test1[0][0]}:")
    print(network.predict(test1)[0][0])

    print(f"[*] Predicted Output for {test2} input, expected output {test2[0][0]}:")
    print(network.predict(test2)[0][0])

    # plot and save figure
    plt.figure(figsize=(15,5))
    plt.plot(network.epochs_list, network.error_list)
    plt.xlabel('Epochs')
    plt.ylabel('Error')
    plt.savefig('ErrorPlot.png')
    