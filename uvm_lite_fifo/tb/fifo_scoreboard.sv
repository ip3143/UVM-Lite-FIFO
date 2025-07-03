class fifo_scoreboard;
    mailbox mon2scb;
    queue [7:0] expected;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    function void push_expected(bit [7:0] data);
        expected.push_back(data);
    endfunction

    task run();
        forever begin
            fifo_transaction t;
            mon2scb.get(t);
            if (expected.size() == 0) begin
                $display("ERROR: Unexpected read: %s", t.sprint());
            end else begin
                bit [7:0] exp = expected.pop_front();
                if (exp !== t.data) begin
                    $display("ERROR: Expected %0h, got %0h", exp, t.data);
                end else begin
                    $display("PASS: Got expected data %0h", t.data);
                end
            end
        end
    endtask
endclass
