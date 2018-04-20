# Convert-Flows
Automatically convert your Node-RED flow-file to use oliverraner's https://github.com/oliverrahner/node-red-contrib-homekit-bridged fork instead of the original https://github.com/mschm/node-red-contrib-homekit version.


Backup is your friend!

Usage:

Stop Node-RED
Run: pwsh -File ./Convert-Flows.ps1 -OldFlow ~/.node-red/flows_xxx.json -NewFlow ./flows_xxx_new.json
Replace the old file with the new
Remove node-red-contrib-homekit
Install node-red-contrib-homekit-bridged
Start Node-RED
