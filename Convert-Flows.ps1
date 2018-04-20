param (
        [Parameter(Mandatory=$true)]
        [string]$OldFlow,
        [Parameter(Mandatory=$true)]
        [string]$NewFlow
)

# Read flow file
$flows = Get-Content -Raw -Path $OldFlow | ConvertFrom-Json

# Create node ID
$rand1 = Get-Random -Minimum 1 -Maximum ([long][math]::pow(2,32)-1)
$rand2 = Get-Random -Minimum 1 -Maximum ([long][math]::pow(2,24)-1)
$major = ([System.String]::Format('{0:X8}', $rand1)).ToLower()
$minor = ([System.String]::Format('{0:X6}', $rand2)).ToLower()
$id = "$major.$minor"

# Create Homekit Bridge node
$props = @{
    id              = $id
    type            = 'homekit-bridge'
    z               = ''
    bridgeName      = 'Default Bridge'
    pinCode         = '111-11-111'
    port            = ''
    manufacturer    = 'Default Manufacturer'
    model           = 'Default Model'
    serialNo        = 'Default Serial Number'
}
$bridge = new-object psobject -Property $props

# Get old Homebridge accessories
$accessories = @()
foreach ($flow in $flows) {
    if ($flow.type -eq "homekit-accessory") {
        $accessories += ,$flow
    }
} 

# Create new flow
$newflows = @()
$newflows += ,$bridge
foreach ($flow in $flows) {
    if ($flow.type -eq "homekit-service") {
        foreach ($accessory in $accessories) {
            if ($accessory.id -eq $flow.accessory) { break }
        }
        
        $flow.PSObject.Properties.Remove("accessory")
        Add-Member -InputObject $flow -MemberType NoteProperty -Name "manufacturer" -Value $accessory.manufacturer
        Add-Member -InputObject $flow -MemberType NoteProperty -Name "model" -Value $accessory.model
        Add-Member -InputObject $flow -MemberType NoteProperty -Name "serialNo" -Value $accessory.serialNo
        Add-Member -InputObject $flow -MemberType NoteProperty -Name "bridge" -Value $bridge.id
        $newflows += $flow
    } elseif ($flow.type -eq "homekit-accessory") {
        #ignore
    } else {
        $newflows += ,$flow
    }
}

# Write new flow to file
convertTo-JSON -depth 6 $newflows | Out-File $NewFlow
