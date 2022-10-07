AS  := nasm
ASF := -fbin

all: apps


# Honestly, the extension doesn't matter that much.
apps:
	@mkdir -p bin/
	$(foreach file, $(ASM_FILES), $(AS) $(ASF) $(file) -o bin/$(basename $(notdir $(file))).com;)


clean:
	@rm -rf bin/