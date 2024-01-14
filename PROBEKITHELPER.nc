%
O9102(ProbeKit Helper Program)
(The Parent Command of ProbeKit, Single Axis Probing)

(User Variables)
#V11=3.0 'Axis Probe Travel Distance

(ProbeKit Private Variables)
#V1=0
#V2=0
#V10=0
#V12=0.0

G0 X0 Y0

#:FIXTUREOFFSET
#PRINT "Choose Fixture Offset E Number. Such as 1 for E1"
#INPUT V10
#PRINT "You have selected fixture E",V10," YES=ENTER, NO=1"
#INPUT V2
#If V2=1 then GOTO:FIXTUREOFFSET
#GOTO:SELECTION

#:SELECTION
#PRINT "Select probe type:"
#PRINT "-3. : Z- Axis Probing"
#PRINT "-2. : Y- Axis Probing"
#PRINT "-1. : X- Axis Probing"
#PRINT " 0. : Custom Probing"
#PRINT "+1. : X+ Axis Probing"
#PRINT "+2. : Y+ Axis Probing"
#PRINT "+4. : XY Bore Probing"
#PRINT "+5. : XY Boss Probing"
#PRINT "+6. : Corner Probing"
#INPUT V1
#PRINT "You have selected probe type",V1," YES=ENTER, NO=1"
#INPUT V2
#If V2=1 then GOTO:SELECTION

#IF V1=-3 THEN GOTO:AXISPROBE
#IF V1=-2 THEN GOTO:AXISPROBE
#IF V1=-1 THEN GOTO:AXISPROBE
#IF V1=0 THEN GOTO:CUSTOM
#IF V1=1 THEN GOTO:AXISPROBE
#IF V1=2 THEN GOTO:AXISPROBE
#IF V1=4 THEN GOTO:XYBORE
#IF V1=5 THEN GOTO:XYBOSS
#IF V1=6 THEN GOTO:CORNER

#:AXISPROBE
#PRINT "Axis Probing"
(Usage: R1-2. R2+5. R3+2. M98 P9100)
R1+V1. R2+V10. R3+V11.
M98 P9100
GOTO:END

#:XYBORE
#PRINT "XY Bore Probing"
#PRINT "Input Aproximate Bore Diameter:"
#INPUT V12
#PRINT "You have selected bore diameter",V12," YES=ENTER, NO=1"
#INPUT V2
R1+4. R2+V10. R3+V12.
M98 P9100
#GOTO:END

#:XYBOSS
#PRINT "XY Boss Probing"
#PRINT "Input Aproximate Boss Diameter:"
#INPUT V12
#PRINT "You have selected boss diameter",V12," YES=ENTER, NO=1"
#INPUT V2
R1+5. R2+V10. R3+V12.
M98 P9100
#GOTO:END


#:ERROR
#PRINT "ERROR: Probe type not found"
#GOTO:END

#:END
M30
%

