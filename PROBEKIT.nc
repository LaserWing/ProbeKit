%
O9100(ProbeKit subprogram)
(The Parent Command of ProbeKit, Single Axis Probing)

(---Axis Probing:  R1-3. to R1+2. ---)
(R1=Axis Selection, R2=Fixture Offset, R3=Travel Distance)
(R1+1. for +X, R1+2. for +Y)
(R1-1. for -X, R1-2. for -Y, R1-3. for -Z)

(Usage: R1-2. R2+5. R3+2. M98 P9100)
(Probe -Y, Fixture Offset 5, 2 inches travel)
(X and Y remove half of the probe diameter from the fixture offset)
(Z probes with tool height offset)
(Results: R4=Probe Point)
(Returns to Start Point)

(---XY Bore Probing: R1+4. ---)
(R1=Selection, R2=Fixture Offset, R3=Approximate Bore Diameter)
(Usage:Jog to center of bore, R1+4. R2+5. R3+5. M98 P9100)
(Results: R1=Center X, R2=Center Y, R4=Probe Diameter)

(---XY Boss Probing: R1+5. ---)
(R1=Selection, R2=Fixture Offset, R3=Approximate Boss Diameter)
(Usage:Jog to center of boss, R1+5. R2+5. R3+5. M98 P9100)
(Results: R1=Center X, R2=Center Y, R4=Probe Diameter)

(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
#V11 = 0.2362 'Probe Diameter
#V12 = 20.0 'Probe feedrate
#V13 = 1.25 'Bore Overtravel Multiplier
#V14 = 1.5 'Boss Overtravel Multiplier
#V15 = 0.75 'Boss/Corner Z Drop Height


(---Setup---)
M64 (Switch to Spindle Probe)
M66 (Turn On Probe)
G80 (Cancel fixed cycles)
G53 (Machine Coordinates)
G90 (Absolute Mode)
G17 (XY Plane Selection)

(---Remove Below, testing only---)
G91 (Relative Mode)
#R1 = -3.0
#R2 = 1.0
#R3 = 4.0
G0X10.
Y10.
G1 F59. X3.
Y3.
X-1.
Y-1.
G90 (Absolute Mode)
(---Remove Above, testing only---)

(---R Values to be used in nc lines---)
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
#IF (R1 = 4) THEN GOTO:BOREPROBE 'Bore Probe
#IF (R1 = 5) THEN GOTO:BOSSPROBE 'Boss Probe
#V1 = 0 'Direction of probe movement 1.0 or -1.0
#IF (R1 = 3) THEN GOTO:FAULT
#IF (R1 < 0) THEN V1 = -1.0
#IF (R1 > 0) THEN V1 = 1.0
#IF (R1 = 0) THEN GOTO:FAULT
#IF (R1 > 5) THEN GOTO:FAULT
#IF (R1 < -3) THEN GOTO:FAULT
#V3 = ABS(R1) 'Absolute value of R1 Axis Selection
#R5 = (R3 * V1) 'Calculated Travel distance of probe
#IF(ABS(R1)=1) THEN GOTO:XPROBE
#IF(ABS(R1)=2) THEN GOTO:YPROBE
#IF(ABS(R1)=3) THEN GOTO:ZPROBE
#GOTO:FAULT 'Should never get here

#:XPROBE
#R6 = R5 + R6
#PRINT "Probe X Axis. Moving Towards: X =",R6
L9101 R1+1. X+R6. Y+R7. Z+R8. F+R4. P1
#FX(V2)=PX1+((V11/2)*V1)
#PRINT "FX=",FX(V2),"For Fixture Offset:",V2
#R4 = FX(V2) 'Return X value
#GOTO:END

#:YPROBE
#R7 = R5 + R7
#PRINT "Probe Y Axis. Moving Towards: Y =",R7
L9101 R1+1. X+R6. Y+R7. Z+R8. F+R4. P1
#FY(V2)=PY1+((V11/2)*V1)
#PRINT "FY=",FY(V2),"For Fixture Offset:",V2
#R4 = FY(V2) 'Return Y value
#GOTO:END

#:ZPROBE
G18 (Plane Selection or else L9101 will error)
#R8 = R5 + R8
#PRINT "Probe Z Axis. Moving Towards: Z =",R8
L9101 R1+1. X+R6. Y+R7. Z+R8. F+R4. P1
#FZ(V2)=(ABS(H(V10))+PZ1)*-1 'Account for tool height offset
#PRINT "FZ=",FZ(V2),"For Fixture Offset:",V2
#R4 = FZ(V2) 'Return Z value
G17 (Return to XY Plane)
#GOTO:END

#:BOREPROBE 'Bore Probe three points circle using math at 60 degree intervals
#R5 = (R3/2.0)*V13 'Movement radius distance with overtravel factor
(Position 1; 0 o clock)
#R6 = V20 + R5
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P1
(Position 2; 4 o clock)
#R6 = V20 + (R5 * cos(300))
#R7 = V21 + (R5 * sin(300))
L9101 R1+1. X+R6. Y+R7. F+R4. P2
(Position 3; 8 o clock)
#R6 = V20 + (R5 * cos(150))
#R7 = V21 + (R5 * sin(150))
L9101 R1+1. X+R6. Y+R7. F+R4. P3
(Calculate Center)
L9101 R1+2. (COMPUTE CENTER)
#FX(V2) = R1
#FY(V2) = R2
G1 F+R4 X+R1 Y+R2 (Move to center)
#GOTO:END

#:BOSSPROBE 'Boss Probe three points circle using math at 60 degree intervals
(Place probe at center of boss above about 1/4 inch)
#R8 = V22 - V15 'Z probing height for boss use
#R9 = V22 'Z safe height
#R5 = (R3/2.0)*V14 'Movement radius distance with overtravel factor
(Position 1; 0 o clock)
#R6 = V20 + R5
#R7 = V21
G1 F+R4 Z+R8 (Move to Z height)
G1 X+R6. Y+R7. F+R4. P1
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P1 (Move back to center)
G1 F+R4 Z+R9 (Return to safe Z height)
G1 F+R4 X+R6 Y+R7 (Move to center)
(Position 2; 4 o clock)
#R6 = V20 + (R5 * cos(300))
#R7 = V21 + (R5 * sin(300))
G1 F+R4 Z+R8 (Move to Z height)
G1 X+R6. Y+R7. F+R4. P2
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P2 (Move back to center)
G1 F+R4 Z+R9 (Return to safe Z height)
G1 F+R4 X+R6 Y+R7 (Move to center)
(Position 3; 8 o clock)
#R6 = V20 + (R5 * cos(150))
#R7 = V21 + (R5 * sin(150))
G1 F+R4 Z+R8 (Move to Z height)
G1 X+R6. Y+R7. F+R4. P3
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P3 (Move back to center)
G1 F+R4 Z+R9 (Return to safe Z height)
G1 F+R4 X+R6 Y+R7 (Move to center)
(Calculate Center)
L9101 R1+2. (COMPUTE CENTER)
#FX(V2) = R1
#FY(V2) = R2
G1 F+R4 X+R1 Y+R2 (Move to center)
#GOTO:END

#:FAULT
#PRINT "Probekit Fault, Input Faulty"
#GOTO:END

#:END
M67 (Turn Off Probe)
M99
