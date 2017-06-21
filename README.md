# Arithmetic Logic Unit
Bryan Ching
Designed for Advanced Digital Design course

The following is a list of system design specifications:

  Inputs:
  - 2 6-bit two’s complement numbers
  - 1 3-bit operations number
    - Add = 000
    - Subtract = 001
    - Equal = 100
    - Greater than = 101
    - Less than = 110
    - A equal 0 = 111
  - 1 mode switch to determine read or write state
  - 1 push-button to read from or write to memory
  - 1 reset switch
  Outputs:
  - 6 7-segment displays
    - 2 for each of the 6-bit two’s complement numbers
    - 2 for the result of the operation
  - 6 LEDs
    - 1 for indicating negative values for each of the 6-bit two’s complement numbers
    - 1 for indicating a negative value for the result of the operation
    - 1 for indicating overflow of the result of the operation
    - 1 for indicating FIFO is full
    - 1 for indicating FIFO is empty
  2 FSMs:
  - 1 for determining state of logical operation
  - 1 for determining read or write state
  FIFO to store up to 8 operations at one time
  Reset that uses asynchronous assert and synchronous deassert
