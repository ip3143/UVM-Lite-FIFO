class fifo_monitor;
    virtual fifo_if vif;
    mailbox mon2scb;

    function new(virtual fifo_if vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task monitor();
        bit valid_d;
        logic [7:0] data_d;

        forever begin
            @(posedge vif.clk);

            valid_d = vif.rd_en && !vif.empty;  // blocking assignment
            data_d = vif.data_out;               // blocking assignment

            if (valid_d) begin
                fifo_transaction t = new();
                t.write = 0;
                t.data = data_d;
                mon2scb.put(t);
            end
        end
    endtask

endclass
