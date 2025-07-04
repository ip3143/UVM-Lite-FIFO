onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_test/dut/clk
add wave -noupdate /fifo_test/dut/reset
add wave -noupdate /fifo_test/dut/wr_en
add wave -noupdate /fifo_test/dut/rd_en
add wave -noupdate /fifo_test/dut/data_in
add wave -noupdate /fifo_test/dut/data_out
add wave -noupdate /fifo_test/dut/full
add wave -noupdate /fifo_test/dut/empty
add wave -noupdate /fifo_test/dut/wr_ptr
add wave -noupdate /fifo_test/dut/rd_ptr
add wave -noupdate /fifo_test/dut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 164
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {360 ps}
