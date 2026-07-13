#!/bin/bash

efibootmgr --create --disk /dev/nvme0n1 --part 1 --loader /EFI/refind/refind_x64.efi --label "rEFInd" --unicode

