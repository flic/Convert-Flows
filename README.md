# Convert-Flows
Automatically convert your Node-RED flow-file to use oliverrahner's [node-red-contrib-homekit-bridged](https://github.com/oliverrahner/node-red-contrib-homekit-bridged) fork instead of the original [node-red-contrib-homekit](https://github.com/mschm/node-red-contrib-homekit) version by mschm.


Backup is your friend!

Usage:

- Stop Node-RED
- Run: pwsh -File ./Convert-Flows.ps1 -OldFlow ~/.node-red/flows_xxx.json -NewFlow ./flows_xxx_new.json
- Replace the old file with the new
- Remove node-red-contrib-homekit
- Install node-red-contrib-homekit-bridged
- Start Node-RED
