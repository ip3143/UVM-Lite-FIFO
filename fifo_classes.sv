class fifo_transaction;
    rand bit write;
    rand bit [7:0] data;

    function string sprint();
        return $sformatf("write=%0b data=0x%0h", write, data);
    endfunction
endclass


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


class fifo_monitor;
    virtual fifo_if vif;
    mailbox mon2scb;

    function new(virtual fifo_if vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task monitor();
        forever begin
            @(posedge vif.clk);
            if (vif.rd_en && !vif.empty) begin
                fifo_transaction t = new();  // declare early
                @(posedge vif.clk);          // wait one cycle after valid read
                t.write = 0;
                t.data  = vif.data_out;
                mon2scb.put(t);
            end
        end
    endtask

endclass




class fifo_scoreboard;
    mailbox mon2scb;
    logic [7:0] expected[$];  //fixed queue declaration

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    function void push_expected(bit [7:0] data);
        expected.push_back(data);
    endfunction

    // bit delay_first = 1;

    task run();
        forever begin
            fifo_transaction t;
            mon2scb.get(t);

            // if (delay_first) begin
            //     delay_first = 0;
            //     continue;
            // end
                
            if (expected.size() == 0) begin
                $display("ERROR: Unexpected read: %s", t.sprint());
            end else begin
                bit [7:0] exp = expected.pop_front();
                $display("Comparing with expected queue size: %0d", expected.size());
                if (exp !== t.data) begin
                    $display("ERROR: Expected %0h, got %0h", exp, t.data);
                end else begin
                    $display("PASS: Got expected data %0h", t.data);
                end
            end
        end
    endtask
endclass