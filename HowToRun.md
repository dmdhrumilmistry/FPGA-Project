# How to Run Simulation

## Using Icarus Verilog
- Navigate to the directory in which *.v files are stored
- Generate output file
    ```bash
    iverilog test.v
    ```
    > `a.out` file will be generated
- Run `a.out` file
    ```bash
    vvp a.out
    ```