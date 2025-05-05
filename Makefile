#Makefile for Lab 3, using GHDL


GHDL=ghdl

SRC=pc.vhdl \
    reg_324.vhdl \
    sign_extend4to16.vhdl \
	full_adder.vhdl \
    mainALU_324.vhdl \
    adder8bit.vhdl \
    sub8bit.vhdl \
    control_324.vhdl \
    mux_324.vhdl \
    print_module.vhdl \
    top_324.vhdl \
    top_324_tb.vhdl

TOP_ENTITY=top_324_tb
WAVE_FILE=top_324.vcd

all: run wave

analyze:
	$(GHDL) -a $(SRC)

elaborate: analyze
	$(GHDL) -e $(TOP_ENTITY)

run: elaborate
	$(GHDL) -r $(TOP_ENTITY) --vcd=$(WAVE_FILE)

wave:
	gtkwave $(WAVE_FILE)

clean:
	rm -f *.o *.cf $(WAVE_FILE)
