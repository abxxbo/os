AS     := nasm
AFLAGS := -fbin


all: mkdirs build_os

mkdirs:
	@mkdir -p obj/ bin/

build_os:
	$(AS) $(AFLAGS) -Isrc/boot/ src/boot/boot.asm -o obj/boot.o
	$(AS) $(AFLAGS) -Isrc/kernel/ src/kernel/kernel.asm -o obj/kernel.o
	cat obj/boot.o obj/kernel.o > bin/os.img
clean:
	@rm -rf bin/ obj/

QEMU_FLAGS := -d int -M smm=off -monitor stdio

run: qemu
qemu: bin/os.img
	qemu-system-x86_64 $(QEMU_FLAGS) -fda $^
