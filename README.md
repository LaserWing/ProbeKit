

## ProbeKit Fadal Renishaw Probing Macros
Fadals are great machines but unfortunately their probing routines are lacking, and the community's willingness to share is low. Now that these machines are largely moved towards small operations and home shops, there is a need to divorce from the closed macro aspect and share the knowledge needed to improve all our lives.

**O9999** - MACROCHOOSER.NC - *Fadal Macro Chooser*
**O9100** - PROBEKIT.NC - *ProbeKit Macro Subprogram*
**O9200** - SETAXIS.NC - *SetAxis Macro*
**O9101** - PROBEAXIS.NC - *Axis Probing Macro*
**O9102** - PORBEBOREBOSS.NC - *Bore and Boss Probing Macro*
**O9103** - PROBECORNER.NC - *Corner Probing Macro*
**O9104** - PROBEWEB.NC - *Web Probing Macro*

This project is licensed under the GPL v3.0 License - see the [LICENSE.md](LICENSE.md) file for details

Please share any improvements you make to these macros. I would love to see them. I left the license out of the macros themselves as I know space is limited on the Fadal, but please include the license if you share them.


## `O9999` Macro Chooser
This macro is a basic fadal custom macro chooser. It allows you to select a macro to run from a list of options. It is not required to use the other macros, but it is good for setup.

## `O9100` ProbeKit Macro Subprogram
* Single Axis
* Bore
* Boss
* Corner
* Internal Corner
* Web

This macro is a helper macro that allows you enter the correct values with printed prompts. It is not required to use the other macros, but it is good for setup. 

Most of these macros start from a known position and return to that position.
![Alt text](images/howto.png?raw=true "HowToImage")

### `O9101` [ProbeKit Single Axis Probing]
* Axis Probing:  R1-3. to R1+2.
    * `R1=Axis Selection`
        * `R1+1. for +X`
        * `R1+2. for +Y`
        * `R1-1. for -X` 
        * `R1-2. for -Y`
        * `R1-3. for -Z`
    * `R2=Fixture Offset`
    * `R3=Travel Distance`

* Usage: `R1-2. R2+5. R3+2. M98 P9101`
    * Place probe tip direction in the direction of travel of face you want to probe.
    * Modify the values within the macro to change the max travel distance
* Results: `R4=Probe Point`

### `O9102` [ProbeKit Bore and Boss Probing]
* Select Probing Type:  R1+1. to R1+2.
    * `R1=Selection`
        * `R1+1. for Bore`
        * `R1+2. for Boss`
    * `R2=Fixture Offset`
    * `R3=Approximate Diameter`
* Usage: `R1+1. R2+5. R3+5. M98 P9102`
    * Place the probe above the boss or inside the bore and probe the diameter
    * modify the values within the macro to change the overtravel and drop height
* Results: `R1=Center X, R2=Center Y, R4=Probed Diameter`

### `O9103` [ProbeKit Corner Probing]
* Select Corner To Probe: R1+1. to R1+4. or R1-1. to R1-4.
    * `R1=Corner Selection`
    * `R2=Fixture Offset`
    * `R3=Probe Distance off Start Corner`
    * Use negative R-values for inside corner probing
* Usage: `R1+1. R2+5. R3+5. M98 P9103`
    * Place the probe above the corner and probe the X Y Z measurements
    * Modify the values within the macro to change the overtravel and drop height
* Results: `R1=X, R2=Y, R3=Z`

### `O9104` [ProbeKit Web Probing]
* Web Probing Selection: R1+1. to R1+3.
    * `R1=Axis Selection`
        * `R1+1. for X`
        * `R1+2. for Y`
        * `R1+3. for X&Y`
    * `R2=Fixture Offset`
    * `R3= X Web Measurement to Probe`
    * `R4= Y Web Measurement to Probe`
* Usage: `R1+1. R2+5. R3+5. M98 P9104`
    * Place the probe in the center of the web and probe the X and/or Y measurements
    * Modify the values within the macro to change the overtravel and drop height
* Results: `R1=X Center, R2=Y Center, R3= X Web Length, R4= Y Web Length`

### Macros Use Positive Tool Length
All Z macros use positive tool length as well as user selectable tool numbers(default is 1) for probe length 

### A Note On User Values
At the top of each macro, there are user values. Adjust these to match your machine, use case, and probe.

**They include:**
* Feed Rate
* Probe Tool Number
* Probe Diameter
* Over Travel Multipliers
* Z Drop Height

*Other more common values are set when using the macro using R values*

### Command Structure 
Call `M98 P9101 to P9104` after setting R values

R1 is the primary value that controls probe flow. Any assignment of R value needs a decimal point as shown bellow. 

**Setting a R value can be done in the following ways**
*Shown we set R1 to 12* 
**In-line:**    `R1+12.`
**In-Macro:**   `#R1 = 12.`
*Shown we set R1 to -12* 
**In-line:**    `R1-12.`
**In-Macro:**   `#R1 = -12.`


Using decimal points prevents the fadal control from inserting .0001 for 1. 

## Disclaimer: Use At Your Own Risk!
Many of these macros are updated often and may cause damage to your machine. I am not responsible for any damage caused by these macros.

I've primarily tested these macros on the fadal emulator and my Fadal VMC20 with a Renishaw OMP40-2 probe on Format 2. I will be testing this more in the future. Misuse of R values can cause unexpected movement. Start slow and test each macro on single step before using it in production.
