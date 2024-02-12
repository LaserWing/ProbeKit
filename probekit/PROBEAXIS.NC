%
O9101(ProbeKit Single Axis Probing)
(---Axis Probing:  R1-3. to R1+2. ---)
(R1=Axis Selection, R2=Fixture Offset, R3=Travel Distance)
(R1+1. for +X, R1+2. for +Y)
(R1-1. for -X, R1-2. for -Y, R1-3. for -Z)
(Usage: R1-2. R2+5. R3+2. M98 P9101)
(Results: R4=Probe Point)

(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
#V11 = 0.2362 'Probe Diameter
#V12 = 20.0 'Probe feedrate

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

(Logical Variables)
#V2 = R2 'Set Input Fixture Offset
#V1 = 0 'Direction of probe movement 1.0 or -1.0
#IF (R1 = 3) THEN GOTO:FAULT
#IF (R1 < 0) THEN V1 = -1.0
#IF (R1 > 0) THEN V1 = 1.0
#IF (R1 = 0) THEN GOTO:FAULT
#IF (R1 > 2) THEN GOTO:FAULT
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
#WAIT
#FX(V2)=PX1+((V11/2)*V1)
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "FX=",FX(V2),"For Fixture Offset:",V2
#R4 = FX(V2) 'Return X value
#PRINT "PRESS ENTER TO EXIT"
#INPUT V99
#GOTO:END

#:YPROBE
#R7 = R5 + R7
#PRINT "Probe Y Axis. Moving Towards: Y =",R7
L9101 R1+1. X+R6. Y+R7. Z+R8. F+R4. P1
#WAIT
#FY(V2)=PY1+((V11/2)*V1)
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "FY=",FY(V2),"For Fixture Offset:",V2
#R4 = FY(V2) 'Return Y value
#PRINT "PRESS ENTER TO EXIT"
#INPUT V99
#GOTO:END

#:ZPROBE
G18 (Plane Selection or else L9101 will error)
#R8 = R5 + R8
#PRINT "Probe Z Axis. Moving Towards: Z =",R8
L9101 R1+1. X+R6. Y+R7. Z+R8. F+R4. P1
#WAIT
#FZ(V2)=PZ1-H(V10) 'Account for tool height offset
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "FZ=",FZ(V2),"For Fixture Offset:",V2
#R4 = FZ(V2) 'Return Z value
#PRINT "PRESS ENTER TO EXIT"
#INPUT V99
G17 (Return to XY Plane)
#GOTO:END

#:FAULT
#PRINT "ProbeKit Fault, Input Faulty"
#GOTO:END

#:END
M67 (Turn Off Probe)
M99
