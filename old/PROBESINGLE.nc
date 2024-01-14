%
O9501(ProbeKit Dialog)

#V1=0
#V2=0
#V3=0
#V4=2.0

#:FIXTUREOFFSET
#PRINT "Choose Fixture Offset E Number. Such as 1 for E1"
#Input V2
#PRINT "You have selected fixture E",V2," YES=ENTER, NO=1"
#INPUT V3
#If V3=1 then GOTO:FIXTUREOFFSET
#GOTO:AXIS

#:LOOP
#PRINT "Probing Axis:", R1, "Fixture Offset:", R2
#PRINT "Paused to Jog to next location. Use option 3 when complete" 
(Pause)
G4 P3600 (Infinate Pause)

#:AXIS
#PRINT "Choose axis. X=1,Y=2,Z=3 for positive direction"
#PRINT "Use negative number for negative direction"
#Input V1
#PRINT "You have selected axis",V1," YES=ENTER, NO=1,"
#PRINT "TRAVELCHANGE=2"
#INPUT V3
#If V3=1 then GOTO:AXIS
#If V3=2 then GOTO:TRAVELCHANGE
#GOTO:PROBE

#:TRAVELCHANGE
#PRINT "Enter travel distance with decimal point:"
#Input V4
#PRINT "You have selected",V4," YES=ENTER, NO=1"
#INPUT V3
#If V3=1 then GOTO:TRAVELCHANGE

#:PROBE
(Call, P9100 ProbeKit)
#R1=V1 'Set Axis
#R2=V2 'Set Fixture Offset
#R3=V4 'Set Probe Travel Distance
M98 P9500 (ProbeKit Cycle)

#PRINT "Probe More? YES=ENTER, NO=1"
#PRINT "If YES machine will Pause for you to jog to next location"
#INPUT V3
#If V3=1 then GOTO:LOOP

#:END
M30