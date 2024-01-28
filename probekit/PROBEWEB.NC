%
O9104(ProbeKit Web Probing)
(---Web Probing: R1+1. ---)
(R1= X use 1., Y use 2., X&Y use 3.)
(R2=Fixture Offset)
(R3= X Web Measurement to Probe)
(R4= Y Web Measurement to Probe)
(Usage: Jog to center, R1+1. R2+4. R3=3. M98 P9104)
(Result: R1=X Center, R2=Y Center, R3= X Web Length, R4= Y Web Length)
(Results only set for all if R1=3.)


(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
#V11 = 0.2362 'Probe Diameter
#V12 = 20.0 'Probe feedrate
#V15 = 0.75 'Z Drop Height
#V16 = 1.5 'Probe inward distance
#V17 = 1 'Overtravel distance each side


(---Setup---)
M64 (Switch to Spindle Probe)
M66 (Turn On Probe)
G80 (Cancel fixed cycles)
G53 (Machine Coordinates)
G90 (Absolute Mode)
G17 (XY Plane Selection)
#R5 = V12 'Probe feedrate R value
#V20 = AX 'Start Points
#V21 = AY
#V22 = AZ

(Logical Variables)
#V2 = R2 'Set Input Fixture Offset
#IF (R1 = 1) THEN GOTO:XWEBPROBE
#IF (R1 = 2) THEN GOTO:YWEBPROBE
#IF (R1 = 3) THEN GOTO:XYWEBPROBE

#:XWEBPROBE
#:XYWEBPROBE
(Part 1)
#R6 = V20 -  ( (R3/2) + V17 ) 'Start Point
#R7 = AY
#R8 = AZ
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
#R8 = AZ - V15 'Drop Probe
G1 G31  Z+R8. F+R5. (Probe Down)
#WAIT
R6=V20
R7=AY
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2(Probe Point)
#WAIT
#R8 = AZ + V15 'Raise Probe
G1 G31  Z+R8. F+R5. (Probe Up)
#WAIT
#R6 = V20
#R7 = V21
#R8 = V22
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
(Part 2)
#R6 = V20 +  ( (R3/2) + V17 ) 'Start Point
#R7 = AY
#R8 = AZ
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
#R8 = AZ - V15 'Drop Probe
G1 G31  Z+R8. F+R5. (Probe Down)
#WAIT
R6=V20
R7=AY
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#R8 = AZ + V15 'Raise Probe
G1 G31  Z+R8. F+R5. (Probe Up)
#WAIT
#FX(V2) = (PX2 - PX1) / 2 'X Center
#R6 = FX(V2)
#R7 = V21
#R8 = V22
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "X: ", R6
#PRINT "PRESS ENTER TO CONTINUE"
#IF (R1 = 3) THEN GOTO:YWEBPROBE
#:GOTO:END

#:YWEBPROBE
(Part 1)
#R6 = AX
#R7 = V21 -  ( (R4/2) + V17 ) 'Start Point
#R8 = AZ
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
#R8 = AZ - V15 'Drop Probe
G1 G31  Z+R8. F+R5. (Probe Down)
#WAIT
R6=AX
R7=V21
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#WAIT
#R8 = AZ + V15 'Raise Probe
G1 G31  Z+R8. F+R5. (Probe Up)
#WAIT
#R6 = V20
#R7 = V21
#R8 = V22
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
(Part 2)
#R6 = AX
#R7 = V21 +  ( (R4/2) + V17 ) 'Start Point
#R8 = AZ
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#WAIT
#R8 = AZ - V15 'Drop Probe
G1 G31  Z+R8. F+R5. (Probe Down)
#WAIT
R6=AX
R7=V21
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#WAIT
#R8 = AZ + V15 'Raise Probe
G1 G31  Z+R8. F+R5. (Probe Up)
#WAIT
#FY(V2) = (PY2 - PY1) / 2 'Y Center
#R6 = V20
#R7 = FY(V2)
#R8 = V22
G1 G31  X+R6. Y+R7. Z+R8. F+R5. (Move to Start Point)
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Y: ", R7
#PRINT "PRESS ENTER TO CONTINUE"
#INPUT V99
#:GOTO:END

#:FAULT
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Probekit Fault, Input Faulty"
#GOTO:END

#:END
#WAIT
#R1 = FX(V2) 'X Center
#R2 = FY(V2) 'Y Center
#R3 = (PX2 - PX1) - #V11 'X Web Length
#R4 = (PY2 - PY1) - #V11 'Y Web Length
M67 (Turn Off Probe)
M99
