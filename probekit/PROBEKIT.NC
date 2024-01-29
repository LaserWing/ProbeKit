%
O9100(ProbeKit Helper Program)
(The Parent Command of ProbeKit)

(ProbeKit Logic Private Variables)
#V31 = 5.0 'Axis Probe Travel Distance
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

#PRINT " -X:-1       -Y:-2      -Z:-3"
#PRINT "  X:1         Y:2"
#PRINT "  XY Bore:4   XY Boss:5"
#PRINT "  Corner:6    Inside-Corner:7"
#PRINT "  X-Web:8     Y-Web:9    XY-Web:10"
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
#PRINT "Input Aproximate Web Distance:"
#INPUT V12
#PRINT "You have selected web distance",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XWEB
#R1=1.
#R2=V10
#R3=V12
M98 P9104
#PRINT "Result X Web Distance:", R3
#PRINT "Press Enter to Continue"
#INPUT V2
#GOTO:END

#:YWEB
#PRINT "Y Web Probing"
#PRINT "Input Aproximate Web Distance:"
#INPUT V12
#PRINT "You have selected web distance",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:YWEB
#R1=2. 
#R2=V10
#R4=V12
M98 P9104
#PRINT "Result Y Web Distance:", R4
#PRINT "Press Enter to Continue"
#INPUT V2
#GOTO:END

#:XYWEB
#PRINT "XY Web Probing"
#PRINT "Input Aproximate X Web Distance:"
#INPUT V12
#PRINT "You have selected web distance",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYWEB
#PRINT "Input Aproximate Y Web Distance:"
#INPUT V13
#PRINT "You have selected web distance",V13," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYWEB
#R1=3.
#R2=V10
#R3=V12
#R4=V13
M98 P9104
#PRINT "Result X Web Distance:", R3
#PRINT "Result Y Web Distance:", R4
#PRINT "Press Enter to Continue"
#INPUT V2
#GOTO:END

#:AXISPROBE
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Axis Probing"
#PRINT " "
#PRINT " "
#PRINT " "
(Usage: R1-2. R2+5. R3+2. M98 P9100)
#R1=V1 
#R2=V10 
#R3=V31
#WAIT
M98 P9101
#GOTO:END

#:XYBORE
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "XY Bore Probing (120 Degrees)"
#PRINT "Input Aproximate Bore Diameter:"
#INPUT V12
#PRINT "You have selected bore diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYBORE
#R1=1.
#R2=V10
#R3=V12
#WAIT
M98 P9102
#PRINT "Result Bore Diameter:", R4
#PRINT "Press Enter to Continue"
#INPUT V2
#GOTO:END

#:XYBOSS
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "XY Boss Probing (120 Degrees)"
#PRINT "Input Aproximate Boss Diameter:"
#INPUT V12
#PRINT "You have selected boss diameter",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:XYBOSS
#R1=2. 
#R2=V10
#R3=V12
#WAIT
M98 P9102
#PRINT "Result Boss Diameter:", R4
#PRINT "Press Enter to Continue"
#INPUT V2
#GOTO:END

#:CORNER
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Corner Probing, Place Probe Above Corner"
#PRINT "1 -- 2"
#PRINT ":    :"
#PRINT "3 -- 4"
#PRINT "Choose Corner. Enter Number 1-4"
#INPUT V12
#PRINT "You have selected corner",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:CORNER
#:CORNERDISTANCEINPUT
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Input Distance on XY from starting point to probe:"
#INPUT V13
#PRINT "You have selected distance",V13," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:CORNERDISTANCEINPUT
(R1=Selection, R2=Fixture Offset, R3=Probe Distance off Start Corner)
#R1=V12
#R2=V10
#R3=V13
#WAIT
M98 P9103
#GOTO:END

#:INTERNALCORNER
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Internal Corner Probing, Place Probe Above Corner"
#PRINT "1 -- 2"
#PRINT ":    :"
#PRINT "3 -- 4"
#PRINT "Choose Corner. Enter Number 1-4"
#INPUT V12
#PRINT "You have selected corner",V12," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:INTERNALCORNER
#:INTERNALCORNERDISTANCEINPUT
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Input Distance on XY from starting point to probe:"
#INPUT V13
#PRINT "You have selected distance",V13," YES=ENTER, NO=1"
#INPUT V2
#IF V2=1 THEN GOTO:INTERNALCORNERDISTANCEINPUT
(R1=Selection, R2=Fixture Offset, R3=Probe Distance off Start Corner)
#R1=V12*-1
#R2=V10
#R3=V13
#WAIT
M98 P9103
#GOTO:END

#:ERROR
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "ERROR: Probe type not found"
#GOTO:END

#:END
M30
%

