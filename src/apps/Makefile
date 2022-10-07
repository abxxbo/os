AS  := nasm
ASF := -fbin

override ASM_FILES := $(shell find ./ | grep .asm)

# Honestly, the extension doesn't matter that much.
apps:
	@mkdir -p bin/
	$(foreach file, $(ASM_FILES), $(AS) $(ASF) $(file) -o bin/$(basename $(notdir $(file))).com;)


clean:
	@rm -rf bin/