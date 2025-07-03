`include "fifo_env.sv"

module fifo_test;
    logic clk = 0, reset = 0;
    always #5 clk = ~clk;

    fifo_if vif(clk, reset);
    fifo #(8, 4) dut (
        .clk(clk), .reset(reset),
        .wr_en(vif.wr_en), .rd_en(vif.rd_en),
        .data_in(vif.data_in), .data_out(vif.data_out),
        .full(vif.full), .empty(vif.empty)
    );

    fifo_transaction tr[10];  
    fifo_env env;

    initial begin

        env = new(vif);

        for (int i = 0; i < 10; i++) begin
            tr[i] = new();  // instantiate each object
            tr[i].write = (i < 5);
            tr[i].data = i + 8'hA0;
        end

        reset <= 1; #20; reset <= 0;

        env.run(tr);

        #100 $finish;

    end


endmodule
