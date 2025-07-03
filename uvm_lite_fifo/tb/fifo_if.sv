interface fifo_if #(parameter WIDTH = 8) (input logic clk, reset);
    logic wr_en, rd_en;
    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;
    logic full, empty;
endinterface
