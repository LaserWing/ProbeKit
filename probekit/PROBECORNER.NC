%
O9103(ProbeKit Corner Probing)
(---Corner Probing: R1+1. to R1+4. or R1-1. to R1-4. ---)
(R1=Corner Selection, R2=Fixture Offset, R3=Probe Distance off Start Corner)
(Use negative R-values for inside corner probing)
( 1---2 )
( |   | )
( 1---4 )
( -1   -2 )
(  |    | )
( -4   -3 )
(Usage: Jog above corner, R1+1. R2+5. R3+5. M98 P9103)
(Result: R1=X, R2=Y, R3=Z)

(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
#V11 = 0.2362 'Probe Diameter
#V12 = 20.0 'Probe feedrate
#V15 = 0.75 'Corner Z Drop Height
#V16 = 1.25 'Corner Off edge travel distance

(---Setup---)
M64 (Switch to Spindle Probe)
M66 (Turn On Probe)
G80 (Cancel fixed cycles)
G53 (Machine Coordinates)
G90 (Absolute Mode)
G17 (XY Plane Selection)
#R4 = V12 'Probe feedrate R value
#R5 = 0.0 
#R6 = AX 'Start Points
#R7 = AY
#R8 = AZ
#R9 = 0.0
#V20 = AX 'Start Points
#V21 = AY
#V22 = AZ

(Logical Variables)
#V2 = R2 'Set Input Fixture Offset
#IF (R1 > 0) THEN GOTO:CORNERPROBE 'Corner Probe
#IF (R1 < 1) THEN GOTO:INTERNALCORNERPROBE 'Corner Probe
#IF (R1 = 0) THEN GOTO:FAULT 'Fault
#IF (R1 < -4 ) THEN GOTO:FAULT 'Fault
#IF (R1 > 4 ) THEN GOTO:FAULT 'Fault

#:CORNERPROBE 'Corner Probe two points
#V17 = 0 'X Axis Direction Flag
#V18 = 0 'Y Axis Direction Flag
#IF (R1=1) THEN V17 = 1 'X Axis Direction Flag
#IF (R1=1) THEN V18 = -1 'Y Axis Direction Flag
#IF (R1=2) THEN V17 = -1 'X Axis Direction Flag
#IF (R1=2) THEN V18 = -1 'Y Axis Direction Flag
#IF (R1=3) THEN V17 = 1 'X Axis Direction Flag
#IF (R1=3) THEN V18 = 1 'Y Axis Direction Flag
#IF (R1=4) THEN V17 = -1 'X Axis Direction Flag
#IF (R1=4) THEN V18 = 1 'Y Axis Direction Flag
(X Axis Probe)
#R7 = V21 + (R3 * V18)
G1 G31 F+R4 Y+R7 (Move to Y)
#R7 = V20 - (V16 * V17)
G1 G31 F+R4 X+R7 (Move to X)
#R7 = V22 - V15
G1 G31 F+R4 Z+R7 (Move to Z)
#R5 = AZ
#R6 = AY
#R7 = AX + (V16 * V17)
L9101 R1+1. X+R7. Y+R6. Z+R5. F+R4. P1 (Probe X and back to start)
#R7 = V22 'Move to Z safe height
G1 G31 F+R4 Z+R7 (Move to Z)
#R7 = V20
#R8 = V21
G1 G31 X+R7 Y+R8 (Move to starting X and Y)
(Y Axis Probe)
#R7 = V20 + (R3 * V17)
G1 G31 F+R4 X+R7 (Move to X)
#R7 = V21 - (V16 * V18)
G1 G31 F+R4 Y+R7 (Move to Y)
#R7 = V22 - V15
G1 G31 F+R4 Z+R7 (Move to Z)
#R5 = AZ
#R6 = AX
#R7 = AY + (V16 * V18)
L9101 R1+1. X+R6. Y+R7. Z+R5. F+R4. P2 (Probe Y and back to start)
#R7 = V22 'Move to Z safe height
G1 G31 F+R4 Z+R7 (Move to Z)
#R7 = V20
#R8 = V21
G1 G31 X+R7 Y+R8 (Move to starting X and Y)
(Z Axis Probe)
#R5 = AZ - V15
#R6 = AY
#R7 = AX
L9101 R1+1. X+R7. Y+R6. Z+R5. F+R4. P3 (Probe Z and back to start)
(Set Values)
#WAIT
#FX(V2) = PX1+((V11/2)*V17)
#FY(V2) = PY2+((V11/2)*V18)
#FZ(V2)=(ABS(H(V10))+PZ3)*-1 'Account for tool height offset
(Returns)
#R1 = FX(V2)
#R2 = FY(V2)
#R3 = FZ(V2)
#GOTO:END

#:INTERNALCORNERPROBE 'Corner Probe two points
#V17 = 0 'X Axis Direction Flag
#V18 = 0 'Y Axis Direction Flag
#IF (R1=-1) THEN V17 = -1 'X Axis Direction Flag
#IF (R1=-1) THEN V18 = 1 'Y Axis Direction Flag
#IF (R1=-2) THEN V17 = 1 'X Axis Direction Flag
#IF (R1=-2) THEN V18 = 1 'Y Axis Direction Flag
#IF (R1=-3) THEN V17 = -1 'X Axis Direction Flag
#IF (R1=-3) THEN V18 = -1 'Y Axis Direction Flag
#IF (R1=-4) THEN V17 = 1 'X Axis Direction Flag
#IF (R1=-4) THEN V18 = -1 'Y Axis Direction Flag
(Since this is a internal corner probe, we need to move off into the part, over away from the corner)
(then towards the edge of the part to probe)
(X Axis Probe)
#R7 = V21 - (R3 * V18) 'Move off into the part
G1 G31 F+R4 Y+R7 (Move to Y)
#R7 = V20 - (V16 * V17)
G1 G31 F+R4 X+R7 (Move to X)
#R7 = V22 - V15
G1 G31 F+R4 Z+R7 (Move to Z)
#R5 = AZ
#R6 = AY
#R7 = AX + (V16 * V17)
L9101 R1+1. X+R7. Y+R6. Z+R5. F+R4. P1 (Probe X and back to start)
#R7 = V22 'Move to Z safe height
G1 G31 F+R4 Z+R7 (Move to Z)
#R7 = V20
#R8 = V21
G1 G31 X+R7 Y+R8 (Move to starting X and Y)
(Y Axis Probe)
#R7 = V20 - (R3 * V17) 'Move off into the part
G1 G31 F+R4 X+R7 (Move to X)
#R7 = V21 - (V16 * V18)
G1 G31 F+R4 Y+R7 (Move to Y)
#R7 = V22 - V15
G1 G31 F+R4 Z+R7 (Move to Z)
#R5 = AZ
#R6 = AX
#R7 = AY + (V16 * V18)
L9101 R1+1. X+R6. Y+R7. Z+R5. F+R4. P2 (Probe Y and back to start)
#R7 = V22 'Move to Z safe height
G1 G31 F+R4 Z+R7 (Move to Z)
#R7 = V20
#R8 = V21
G1 G31 X+R7 Y+R8 (Move to starting X and Y)
(Z Axis Probe)
#R5 = AZ - V15
#R6 = AY
#R7 = AX
L9101 R1+1. X+R7. Y+R6. Z+R5. F+R4. P3 (Probe Z and back to start)
(Set Values)
#WAIT
#FX(V2) = PX1+((V11/2)*V17)
#FY(V2) = PY2+((V11/2)*V18)
#FZ(V2)=(ABS(H(V10))+PZ3)*-1 'Account for tool height offset
(Returns)
#R1 = FX(V2)
#R2 = FY(V2)
#R3 = FZ(V2)
#GOTO:END

#:FAULT
#PRINT "Probekit Fault, Input Faulty"
#GOTO:END

#:END
M67 (Turn Off Probe)
M99
