Param(
    $WriteROM,
    $WriteRAM,
    $WriteMBC,
    $ReadRAM
)

$DFU_UTIL_PATH = ".\dfu-util.exe"

if( !($WriteROM -Or $WriteRAM -Or $WriteMBC -Or $ReadRAM) ){
    Write-Host "Usage: pcbif.ps1 OPTIONS FILE"
    Write-Host "  This is cartridge read/write interface."
    Write-Host "  For more detail, please refer to this page. https://niccol.li/cartridge/"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -WriteROM   Write FILE to ROM area."
    Write-Host "  -WriteRAM   Write FILE to RAM area."
    Write-Host "  -WriteMBC   Write FILE to MBC area."
    Write-Host "  -ReadRAM    Read saved RAM data to FILE."
    Write-Host ""
    Exit
}

if($WriteROM){
    &($DFU_UTIL_PATH) -D $WriteROM -d 0483:df11 -a 0 -s 0x08100000 -Z 0x100000
    Exit
}
if($WriteRAM){
    &($DFU_UTIL_PATH) -D $WriteRAM -d 0483:df11 -a 0 -s 0x080E0000 -Z 0x20000
    Exit
}
if($WriteMBC){
    &($DFU_UTIL_PATH) -D $WriteMBC -d 0483:df11 -a 0 -s 0x08000000
    Exit
}
if($ReadRAM){
    &($DFU_UTIL_PATH) -U $ReadRAM -d 0483:df11 -a 0 -s 0x080E0000 -Z 0x20000
    Exit
}
