AS     := nasm
AFLAGS := -fbin
INCLUDE_DIRS := -Isrc/kernel -Ikernel_drivers/

LOOPBACK := loop20
OUTPUT   := bin/os.flp

all: mkdirs build_os

mkdirs:
	@mkdir -p obj/ bin/

build_os:
	make -C test_coms
	make -C src/apps

	$(AS) $(AFLAGS) -Isrc/boot/ src/boot/boot.asm -o obj/boot.o
	$(AS) $(AFLAGS) $(INCLUDE_DIRS) src/kernel/kernel.asm -o obj/kernel.o
	dd if=/dev/zero of=$(OUTPUT) bs=512 count=2880
	sudo losetup /dev/$(LOOPBACK) $(OUTPUT)
	sudo mkdosfs -F 12 /dev/$(LOOPBACK)
	sudo mount /dev/$(LOOPBACK) /mnt -t msdos -o "fat=12"

	sudo cp obj/kernel.o /mnt/kernel.bin
	sudo cp on_fs/* /mnt/

	@echo Copying all files to root directory...
	sudo cp test_coms/bin/* /mnt/ -v
	# sudo cp src/apps/bin/* /mnt/ -v

	sudo umount /mnt
	sudo losetup -d /dev/$(LOOPBACK)

	dd status=noxfer conv=notrunc count=1 if=obj/boot.o of=$(OUTPUT)

clean:
	@rm -rf bin/ obj/
	make -C test_coms clean
	make -C src/apps clean

QEMU_FLAGS := -d int -M smm=off -monitor stdio -soundhw pcspk

run: qemu
qemu: $(OUTPUT)
	qemu-system-x86_64 $(QEMU_FLAGS) -fda $^
