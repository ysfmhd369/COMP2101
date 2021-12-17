param ($System, $Disks, $Network)

if ($System){
    get-hardware
    get-operatingsystem
    get-processor
    get-video
}
if ($Disks){
    get-ram
    get-drive   
}
if($Network){
    get-network
}
