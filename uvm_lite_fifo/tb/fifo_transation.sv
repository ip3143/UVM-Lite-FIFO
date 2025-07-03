class fifo_transaction;
    rand bit write;
    rand bit [7:0] data;

    function string sprint();
        return $sformatf("write=%0b data=0x%0h", write, data);
    endfunction
endclass
