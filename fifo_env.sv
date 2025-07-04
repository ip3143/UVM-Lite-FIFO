`include "fifo_classes.sv"

class fifo_env;
    fifo_driver drv;
    fifo_monitor mon;
    fifo_scoreboard scb;

    mailbox mon2scb = new();

    function new(virtual fifo_if vif);
        drv = new(vif);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction

    task run(fifo_transaction tr[10]);
        fork
            mon.monitor();
            scb.run();
        join_none

        foreach (tr[i]) begin
            if (tr[i].write)
                scb.push_expected(tr[i].data);
            drv.drive(tr[i]);
        end

        #10; // wait a few cycles for monitor to complete
    endtask
endclass