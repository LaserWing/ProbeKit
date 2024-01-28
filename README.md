## Disclaimer
# Use At Your Own Risk!
Many of these macros are untested and may cause damage to your machine. I am not responsible for any damage caused by these macros.

I've primarily tested these macros on the fadal emulator and my Fadal VMC20 with a Renishaw OMP40-2 probe on Format 2. I will be testing this more in the future. Misuse of R values can cause unexpected movement. Start slow and test each macro on single step before using it in production.

## License
This project is licensed under the GPL v3.0 License - see the [LICENSE.md](LICENSE.md) file for details

Please share any improvements you make to these macros. I would love to see them. I left the license out of the macros themselves as I know space is limited on the Fadal, but please include the license if you share them.

# ProbeKit Fadal Renishaw Probing Macros
Fadals are great machines but unfortunately their probing routines are lacking, and the community's willingness to share is low. Now that these machines are largely moved towards small operations and home shops, there is a need to divorce from the closed macro aspect and share the knowledge needed to improve all our lives.

## 09200 SetAxis Macro
This macro is for use with Haimer style 3d tasters. It is not required to use the other macros, but it is good for setup when a probe is not suitable.


## O9100 ProbeKit Macro Subprogram
* Single Axis
* Bore
* Boss
* Corner
* Internal Corner
* Web

This macro is a helper macro that allows you enter the correct values with printed prompts. It is not required to use the other macros, but it is good for setup. 

Most of these macros start from a known position and return to that position.


## A Note On User Values
Each macro has user variables that can be set to change the default values. These are set in the macro itself. The default values are set for my machine and probe. You will need to change these to match your machine and probe.

These include feed rate, z drop height, tool number, probe diameter, overtravel multipliers, and others.

Refer to each macro for R value usage and user values. 

## Command Structure 
Call `M98 P9101 to P9103` after setting R values

R1 is the primary value that controls probe flow. Any assignment of R value needs a decimal point as shown bellow. 

### Axis Probing:  R1-3. to R1+2.
`R1=Axis Selection`
`R2=Fixture Offset`
`R3=Travel Distance`
* Single Axis `P9101`
    * `R1+1.` probes X+
    * `R1-1.` probes X-
    * `R1+2`. probes Y+
    * `R1-2.` probes Y-
    * `R1-3.` probes Z-
* X and Y remove half of the probe diameter from the fixture offset
* Z probes with tool height offset

##### Results and Returns
Usage: 
1. `R1-2. R2+5. R3+2. M98 P9100`
2. Probe -Y, Fixture Offset 5, 2 inches travel
3. returns R4 set to the probed point
4. Probe moves start point

### XY Bore Probing: R1+1.
`R1=Selection`
`R2=Fixture Offset`
`R3=Approximate Bore Diameter`
* Bore and Boss `P9102`
    * `R1+1.` probes bore
    * `R1+2.` probes boss

##### Results and Returns:
Usage: 
1. Jog to center of bore
2. R1+4. R2+5. R3+5. M98 P9100
3. returns R1=Center X, R2=Center Y, R4=Probe Diameter
4. Probe moves start point

###XY Boss Probing: R1+2.
`R1=Selection`
`R2=Fixture Offset`
`R3=Approximate Bore Diameter`
##### Results and Returns:
Usage: 
1. Jog above center of Boss
2. R1+5. R2+5. R3+5. M98 P9100
3. returns R1=Center X, R2=Center Y, R4=Probe Diameter
4. Probe moves start point

###XY Corner Probing: R1+1.
`R1=Selection of Corner 1->4`
`R2=Fixture Offset`
`R3=Probe Distance Off Start Corner`
`1-----2`
`|     |`
`|     |`
`4-----3`
* Corner `P9103`
    * `R1+1. -> 4.` probes corner. Use negative values to probe interior corners

##### Results and Returns:
Usage:
1. Jog above corner
2. R1+1. R2+5. R3+1. M98 P9100
3. returns R1=Corner X, R2=Corner Y, R3=Corner Z

### Setup
1. Set user variables in the macro
2. Copy the macro to the machine
3. Call the macro with the appropriate R values

`V10 = 1 'Tool Number for tool height offset`
`V11 = 0.2362 'Probe Diameter`
`V12 = 20.0 'Probe feedrate`
`V13 = 1.25 'Bore Overtravel Multiplier`
`V14 = 1.5 'Boss Overtravel Multiplier`
`V15 = 0.75 'Boss/Corner Z Drop Height`

