default:
    just -l

fetch-build:
    gh run download -n firmware

disk := '/dev/sda'
flash side drive=disk:
    udisksctl mount -b {{drive}}
    cp lily58_{{side}}-nice_nano-zmk.uf2 /run/media/$USER/NICENANO/
