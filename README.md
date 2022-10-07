# OS
A 16-bit os for learning purposes.

**DISCLAIMER**: Not all this code is mine. I have to give credit to [MascOS](https://github.com/leo007er1/MascOS) for
the FAT12 code.

## Compilation
This will require sudo (to setup loopback device)
```
make
```

# Roadmap

## Main
- [X] Fat12 bootloader
- [X] COM Loading
- [ ] Login system (potentially)

## Drivers
- [X] PC Speaker
- [ ] PCI (?)
- [ ] RTL8139 / E1000 Ethernet

## Applications
- [ ] Text Editor

## Syscalls
- [X] `sys_write`
- [ ] `sys_exit`

## Improvements on pre-existing features
- [ ] Have shell do argc/argv