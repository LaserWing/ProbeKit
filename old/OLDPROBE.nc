%
O9100(ProbeKit subprogram)
(Call me with MDI command R1+1. R2+1. R3+4 M98 P9006)
(This results in a probe of +X, Fixture Offset 1, 4 inches travel)
(Set R1 to 1 for +X, 2 for +Y, 3 for +-Z)
(Set R1 to -1 for -X, -2 for -Y)
(Set R2 with fixture offset number)
(Set R3 with travel distance)

(R1=Axis Selection, R2=Fixture Offset, R3=Travel Distance)
(G91 mode is used for relative movement)


(Plus and Minus Signs in nccode R values actually act as a signed equal sign)
(Example: R1+1. = #R1=1)
(Must use G90, L9101 shifts into G91, and back)

M64 (Switch to Spindle Probe)
M66 (Turn On Probe)
G80 (Cancel fixed cycles)
G91 (Relative Mode)
G53 (Machine Coordinates)

(Remove Below, testing only)
#R1 = 2.0
#R2 = 1.0
#R3 = 1.0
G0X10.
Y10.
G1 F59. X3.
Y3.
X-1.
Y-1.
(Remove Above, testing only)

(clear R variables)
#R4 = 0.0
#R5 = 0.0
#R6 = 0.0
#R7 = 0.0
#R8 = 0.0
#R9 = 0.0

(Logical Variables)
#V1 = 0 'Direction of probe movement 1.0 or -1.0
#IF (R1 < 0) THEN V1 = -1.0
#IF (R1 > 0) THEN V1 = 1.0
#V2 = R2 'Fixture Offset
#V3 = ABS(R1) 'Absolute value of R1 Axis Selection

(User)
#V10 = R3 'Travel distance of probe
#V11 = 0.25 'Probe diameter in inches
#V12 = 20.0 'Probe feedrate

(R Variables to be used in nc lines)
#R4 = V12 'Probe feedrate R value
#R5 = V10 * V1 'Calculated Travel distance of probe
#R6 = 0.005 * V1 'Over travel distance of probe
#R7 = 0.125 * V1 'Back Off distance of probe
#R8 = 0.005 * V1 'Back More distance of probe
#R9 = 0.5 * V1 'Probe touch distance 

#IF(ABS(R1)=3) THEN #FZ(V2)=-1
#IF(ABS(R1)=1) THEN GOTO:XPROBE
#IF(ABS(R1)=2) THEN GOTO:YPROBE
#IF(ABS(R1)=3) THEN GOTO:ZPROBE


#:XPROBE
G1 G31 X+R5 F+R4 (INITIAL TOUCH  
X+R6 F10. (OVER TRAVEL PROBE SWITCH
G31.1 X-R7 F10. (MOVES UNTIL NO TOUCH
X-R8 F10. (MOVES OFF .005 MORE
G31 X+R5 F.5 P1 (FINAL TOUCH
(Touch Check, if no touch, abort)
L9101 R1+7. R2+0 R3+1. (Abort on No Touch, r2 is false in, r3 is true in, output is back on R2)
#IF (R2=1) THEN GOTO:FAULT
(Set Fixture Offset)
#FX(V2)=PX1+((V11/2)*V1)
(Move Backwards to clear probe)
G1 X-R9 F10.
#PRINT "FX=",FX(V2),"For Fixture Offset:",V2
#GOTO:END

#:YPROBE
G1 G31 Y+R5 F+R4 (INITIAL TOUCH  
Y+R6 F10. (OVER TRAVEL PROBE SWITCH
G31.1 Y-R7 F10. (MOVES UNTIL NO TOUCH
Y-R8 F10. (MOVES OFF .005 MORE
G31 Y+R5 F.5 P1 (FINAL TOUCH
(Touch Check, if no touch, abort)
L9101 R1+7. R2+0 R3+1. (Abort on No Touch, r2 is false in, r3 is true in, output is back on R2)
#IF (R2=1) THEN GOTO:FAULT
(Set Fixture Offset)
#FY(V2)=PY1+((V11/2)*V1)
(Move Backwards to clear probe)
G1 Y-R9 F10.
#PRINT "FY=",FY(V2),"For Fixture Offset:",V2
#GOTO:END

#:ZPROBE
G1 G31 Z+R5 F+R4 (INITIAL TOUCH  
Z+R6 F10. (OVER TRAVEL PROBE SWITCH
G31.1 Z-R7 F10. (MOVES UNTIL NO TOUCH
Z-R8 F10. (MOVES OFF .005 MORE
G31 Z+R5 F.5 P1 (FINAL TOUCH

(Touch Check, if no touch, abort)
L9101 R1+7. R2+0 R3+1. (Abort on No Touch, r2 is false in, r3 is true in, output is back on R2)
#IF (R2=1) THEN GOTO:FAULT
(Set Fixture Offset)
#FZ(V2)=(ABS(H1)+PZ1)*-1
(Move Backwards to clear probe)
G1 Z-R9 F10.
#PRINT "FZ=",FZ(V2),"For Fixture Offset:",V2
#GOTO:END

#:FAULT
#PRINT "Probe Fault, No Touch"

#:END
M99