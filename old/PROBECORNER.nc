%
O9007(ProbeKit Dialog)

(temporary variables)
#V1 = 0
#V2 = 0

(parametric variables)
#V10 = 0 'Fixture Offset E Number
#V11 = 0 'Corner Number
#V12 = 0 'X Axis direction (1 or -1)
#V13 = 0 'Y Axis direction (2 or -2)

(Setting Variables)
#V20 = 0.5 'inward jog distance
#V21 = 1 'probe edge travel distance

(private variables)
#R1=0
#R2=0

(usable R values)
#R3=0 'X axis probe position

#:FIXTUREOFFSET
#Print "Choose Fixture Offset E Number. Such as 1 for E1"
#Input V10
#Print "You have selected fixture E",V1," YES=ENTER, NO=1"
#INPUT V2
#If V2=1 then GOTO:FIXTUREOFFSET
#GOTO:AXIS

#:AXIS
#Print "Choose Corner. Enter Number 1-4"
#Print "1 -- 2"
#Print "|    |"
#Print "|    |"
#Print "3 -- 4"
#Input V11
#Print "You have selected axis",V1," YES=ENTER, NO=1"
#INPUT V2
#If V2=1 then GOTO:AXIS

(Set Corner travel directions)
(Corner 1)
#IF (V11=1) THEN V12=1
#IF (V11=1) THEN V13=-2
(Corner 2)
#IF (V11=2) THEN V12=-1
#IF (V11=2) THEN V13=-2
(Corner 3)
#IF (V11=3) THEN V12=1
#IF (V11=3) THEN V13=2
(Corner 4)
#IF (V11=4) THEN V12=-1
#IF (V11=4) THEN V13=2


#Print "Probing Corner:", R1, "Fixture Offset:", R2
#Print "Paused to Jog 1 inch directly above corner."
#Print "Use option 3 when complete" 
(Pause)
G4 P3600 'Pause forever
G91 'Incremental Mode








#R1=V10
#R2=SETME ()
M98 P9100


#:END
M30