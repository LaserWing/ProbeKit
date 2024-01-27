%
O9100(ProbeKit Helper Program)
(The Parent Command of ProbeKit)

(User Variables V30+)
#V30 = 0
#V31 = 3.0 'Axis Probe Travel Distance


(Corner)
#V35 = 1 'X Movement Distance
#V36 = 1 'Y Movement Distance
#V37 = 1 'Z Drop Distance
#V40 = 0 'X Probe Start Position
#V41 = 0 'Y Probe Start Position
#V42 = 0 'Z Probe Safe Position

(ProbeKit Logic Private Variables)
#V1=0
#V2=0
#V10=0
#V12=0.0

#:FIXTUREOFFSET
#PRINT "Choose Fixture Offset E Number. Such as 1 for E1"
#INPUT V10
#PRINT "You have selected fixture E",V10," YES=ENTER, NO=1"
#INPUT V2
#If V2=1 then GOTO:FIXTUREOFFSET
#GOTO:SELECTION

#:SELECTION
#PRINT "Select probe type:"
#PRINT "-3.: Z-        -2. : Y-      -1. : X-"
#PRINT "+1.: X+        +2. : Y+"
#PRINT "+4.: XY Bore   +5. : XY Boss"
#PRINT "+6. : Corner   +7. : Internal Corner"
#PRINT "+8. : X Web    +9. : Y Web   +10.: XY Web"

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
#IF V1=7 THEN GOTO:INTERNALCORNER
#IF V1=8 THEN GOTO:XWEB
#IF V1=9 THEN GOTO:YWEB
#IF V1=10 THEN GOTO:XYWEB

#:XWEB
#PRINT "X Web Probing"
#PRINT "Input Aproximate Web Diameter:"
#INPUT V12
#PRINT "You have selected web diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XWEB
#R1=1.
#R2=V10
#R3=V12
M98 P9104
#GOTO:END

#:YWEB
#PRINT "Y Web Probing"
#PRINT "Input Aproximate Web Diameter:"
#INPUT V12
#PRINT "You have selected web diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:YWEB
#R1=2. 
#R2=V10
#R4=V12
M98 P9104
#GOTO:END

#:XYWEB
#PRINT "XY Web Probing"
#PRINT "Input Aproximate X Web Diameter:"
#INPUT V12
#PRINT "You have selected web diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYWEB
#PRINT "Input Aproximate Y Web Diameter:"
#INPUT V13
#PRINT "You have selected web diameter",V13," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYWEB
#R1=3.
#R2=V10
#R3=V12
#R4=V13
M98 P9104
#GOTO:END


#:AXISPROBE
#PRINT "Axis Probing"
(Usage: R1-2. R2+5. R3+2. M98 P9100)
#R1=V1 
#R2=V10 
#R3=V31
M98 P9101
#GOTO:END

#:XYBORE
#PRINT "XY Bore Probing"
#PRINT "Input Aproximate Bore Diameter:"
#INPUT V12
#PRINT "You have selected bore diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYBORE
#R1=1.
#R2=V10
#R3=V12
M98 P9102
#GOTO:END

#:XYBOSS
#PRINT "XY Boss Probing"
#PRINT "Input Aproximate Boss Diameter:"
#INPUT V12
#PRINT "You have selected boss diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYBOSS
#R1=2. 
#R2=V10
#R3=V12
M98 P9102
#GOTO:END

#:CORNER
#PRINT "Corner Probing"
#Print "Choose Corner. Enter Number 1-4"
#Print "1 -- 2"
#Print "|    |"
#Print "|    |"
#Print "3 -- 4"
#INPUT V12
#PRINT "You have selected corner",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:CORNER
#:CORNERDISTANCEINPUT
#PRINT "Input Distance on XY from starting point to probe:"
#PRINT "-----V----"
#PRINT "|         |"
#PRINT "|         |"
#PRINT "|         <"
#PRINT "|         |"
#PRINT "----------"
#INPUT V13
#PRINT "You have selected distance",V13," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:CORNERDISTANCEINPUT
(R1=Selection, R2=Fixture Offset, R3=Probe Distance off Start Corner)
#R1=V12
#R2=V10
#R3=V13
M98 P9103
#GOTO:END

#:ERROR
#PRINT "ERROR: Probe type not found"
#GOTO:END

#:END
M30
%

