if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -sv -work work [pwd]/toplevel_testbench.sv
vlog -sv -work work [pwd]/toplevel_lab7.sv
vlog -sv -work work [pwd]/fsm_lab7.sv
vlog -sv -work work [pwd]/fsm_rw_lab7.sv
vlog -sv -work work [pwd]/synchronizer_lab7.sv
vlog -sv -work work [pwd]/adder.sv
vlog -sv -work work [pwd]/subtractor.sv
vlog -sv -work work [pwd]/equal.sv
vlog -sv -work work [pwd]/greater.sv
vlog -sv -work work [pwd]/less.sv
vlog -sv -work work [pwd]/zero.sv
vlog -sv -work work -suppress 7061 [pwd]/memory.sv
vlog -sv -work work [pwd]/display.sv
vlog -sv -work work [pwd]/decimal.sv
vlog -sv -work work [pwd]/reset_lab7.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim toplevel_testbench 
# should it be the testbench or actual file?

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave *
add wave dutlab7/module3/dataIn
add wave dutlab7/module3/dataOut
add wave dutlab7/module10/result
add wave dutlab7/module4/nA_LED
add wave dutlab7/module4/nB_LED
add wave dutlab7/module4/nR_LED
add wave dutlab7/*

### Force waves here ###

### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure 

# to see all signal names and current values
view signals 

### ---------------------------------------------- ###
### Edit run time ###
run 1000 ns     

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull 
