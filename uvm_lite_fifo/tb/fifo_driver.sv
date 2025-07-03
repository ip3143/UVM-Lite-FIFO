class fifo_driver;
    virtual fifo_if vif;

    function new(virtual fifo_if vif);
        this.vif = vif;
    endfunction

    task drive(fifo_transaction t);
        if (t.write) begin
            @(posedge vif.clk);
            vif.wr_en <= 1;
            vif.data_in <= t.data;
            @(posedge vif.clk);
            vif.wr_en <= 0;
        end else begin
            @(posedge vif.clk);
            vif.rd_en <= 1;
            @(posedge vif.clk);
            vif.rd_en <= 0;
        end
    endtask
endclass
