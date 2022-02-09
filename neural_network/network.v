module NeuralNetwork;
    /*
    Set weights after training the model using python
    */
    real w1 = 16.24626435;
    real w2 = -0.83481771;
    real w3 = -7.75517113;
    real e = 2.718281828459045;


    /*
    function: Predict
    args: x1, x2
    description: predicts the neural trained neural network output using calculated weights
    */
    function real predict(input integer x1, x2, x3);
        real partial_result;
        real result;
        
        begin
            $display("x1 : %f", x1);
            $display("x2 : %f", x2);
            $display("x3 : %f", x3);
            
            // predict result
            partial_result = (w1*x1) + (w2*x2) + (w3*x3);
            result = 1 / (1 + e**(-1 * partial_result));
            predict = result;
        end
    endfunction    


    initial begin
        $display("Implementation of neural network using FPGA:");
        $display("---------------");
        
        $display("Weights:");
        $display("w1:\t%f", w1);
        $display("w2:\t%f", w2);
        $display("w3:\t%f", w3);
        $display("---------------");

        $display("Predicted Output :", predict(1,1,0));
        $display("---------------");

        $display("Predicted Output :", predict(0,1,0));
        $display("---------------");


    end

endmodule