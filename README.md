# ProbeKit Fadal Renishaw Probing Macros
Fadals are great machines but unfortunately their probing routines are lacking, and the community's willingness to share is low. Now that these machines are largely moved towards small operations and home shops, there is a need to divorce from the closed macro aspect and share the knowledge needed to improve all our lives.

## Macro Functions
* Single Axis
* Bore
* Boss
* Corner

## Command Structure 
Call `M98 P9100` after setting R values

R1 is the primary value that controls probe flow. Any assignment of R value needs a decimal point as shown bellow. 

* Single Axis
    * `R1+1.` probes X+
    * `R1-1.` probes X-
    * `R1+2`. probes Y+
    * `R1-2.` probes Y-
    * `R1-3.` probes Z-
* Bore and Boss
    * `R1+4.` probes bore
    * `R1+5.` probes boss
* Corner
    * `R1+6.` probes corner

### Axis Probing:  R1-3. to R1+2.
`R1=Axis Selection`
`R2=Fixture Offset`
`R3=Travel Distance`
* X and Y remove half of the probe diameter from the fixture offset
* Z probes with tool height offset

##### Results and Returns
Usage: 
1. `R1-2. R2+5. R3+2. M98 P9100`
2. Probe -Y, Fixture Offset 5, 2 inches travel
3. returns R4 set to the probed point
4. Probe moves start point

### XY Bore Probing: R1+4.
`R1=Selection`
`R2=Fixture Offset`
`R3=Approximate Bore Diameter`
##### Results and Returns:
Usage: 
1. Jog to center of bore
2. R1+4. R2+5. R3+5. M98 P9100
3. returns R1=Center X, R2=Center Y, R4=Probe Diameter
4. Probe moves start point

###XY Boss Probing: R1+5.
`R1=Selection`
`R2=Fixture Offset`
`R3=Approximate Bore Diameter`
##### Results and Returns:
Usage: 
1. Jog above center of Boss
2. R1+5. R2+5. R3+5. M98 P9100
3. returns R1=Center X, R2=Center Y, R4=Probe Diameter
4. Probe moves start point

###XY Corner Probing: R1+6.
`R1=Selection`
`R2=Fixture Offset`
`R3=Corner Selection (1-4)`
##### Results and Returns:
Usage:
1. Jog above corner
2. R1+6. R2+5. R3+1. M98 P9100
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



## Disclaimer
# Use At Your Own Risk!