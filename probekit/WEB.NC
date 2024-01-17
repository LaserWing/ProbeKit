%
O9104(ProbeKit Corner Probing)
(---Web Probing: R1+1. ---)
(R1= X use 1., Y use 2.)
(R2=Fixture Offset)
(R3=Web Measurement to Probe)
(Usage: Jog to center, R1+1. R2+4. R3=3. M98 P9104)
(Result: R1=Center In Xxis, R2=Fixture Offset, R3=Web Length)

(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
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
#R4 = V12 'Probe feedrate R value
#V20 = AX 'Start Points
#V21 = AY
#V22 = AZ

(Logical Variables)
#V2 = R2 'Set Input Fixture Offset
#IF (R1 = 1) THEN GOTO:XWEBPROBE
#IF (R1 = 2) THEN GOTO:YWEBPROBE

#:XWEBPROBE 'Web Probe two points
(Part 1)
#R6 = V20 -  ( (R3/2) - V17 ) 'Start Point
#R7 = AY
#R8 = AZ
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#R8 = AZ - V15 'Drop Probe
G1 Z+R8. F+R4. (Probe Down)
R6=V20
R7=AY
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2(Probe Point)
#R8 = AZ + V15 'Raise Probe
G1 Z+R8. F+R4. (Probe Up)
#R6 = V20
#R7 = V21
#R8 = V22
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
(Part 2)
#R6 = V20 +  ( (R3/2) + V17 ) 'Start Point
#R7 = AY
#R8 = AZ
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#R8 = AZ - V15 'Drop Probe
G1 Z+R8. F+R4. (Probe Down)
R6=V20
R7=AY
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#R8 = AZ + V15 'Raise Probe
G1 Z+R8. F+R4. (Probe Up)
#FX(V2) = (PX2 - PX1) / 2 'X Center
#R6 = FX(V2)
#R7 = V21
#R8 = V22
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#:GOTO:END

#:YWEBPROBE 'Web Probe two points
(Part 1)
#R6 = AX
#R7 = V21 -  ( (R3/2) - V17 ) 'Start Point
#R8 = AZ
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#R8 = AZ - V15 'Drop Probe
G1 Z+R8. F+R4. (Probe Down)
R6=AX
R7=V21
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#R8 = AZ + V15 'Raise Probe
G1 Z+R8. F+R4. (Probe Up)
#R6 = V20
#R7 = V21
#R8 = V22
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
(Part 2)
#R6 = AX
#R7 = V21 +  ( (R3/2) + V17 ) 'Start Point
#R8 = AZ
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#R8 = AZ - V15 'Drop Probe
G1 Z+R8. F+R4. (Probe Down)
R6=AX
R7=V21
R8=AZ
L9101 R+1. X+R6. Y+R7. Z+R8. P2 (Probe Point)
#R8 = AZ + V15 'Raise Probe
G1 Z+R8. F+R4. (Probe Up)
#FY(V2) = (PY2 - PY1) / 2 'Y Center
#R6 = V20
#R7 = FY(V2)
#R8 = V22
G1 X+R6. Y+R7. Z+R8. F+R4. (Move to Start Point)
#:GOTO:END

#:FAULT
#PRINT "Probekit Fault, Input Faulty"
#GOTO:END

#:END
M67 (Turn Off Probe)
M99
