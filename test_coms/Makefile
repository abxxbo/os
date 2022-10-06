AS  := nasm
ASF := -fbin

override ASM_FILES := $(shell find ./ | grep .asm)

all: test_coms

test_coms:
	mkdir -p bin/
	$(foreach file, $(ASM_FILES), $(AS) $(ASF) $(file) -o bin/$(basename $(notdir $(file))).com;)

clean:
	rm -rf bin/