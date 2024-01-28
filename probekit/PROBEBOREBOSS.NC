%
O9102(ProbeKit Bore Boss Probing)
(---XY Bore Probing: R1+1. ---)
(R1=Selection, R2=Fixture Offset, R3=Approximate Bore Diameter)
(Usage: Jog to center of bore, R1+4. R2+5. R3+5. M98 P9102)
(Results: R1=Center X, R2=Center Y, R4=Probe Diameter)

(---XY Boss Probing: R1+2. ---)
(R1=Selection, R2=Fixture Offset, R3=Approximate Boss Diameter)
(Usage: Jog to center of boss, R1+5. R2+5. R3+5. M98 P9102)
(Results: R1=Center X, R2=Center Y, R4=Probe Diameter)

(---ProbeKit User Variables---)
#V10 = 1 'Tool Number for tool height offset
#V12 = 20.0 'Probe feedrate
#V13 = 1.25 'Bore Overtravel Multiplier
#V14 = 1.5 'Boss Overtravel Multiplier
#V15 = 0.75 'Boss Z Drop Height

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
#IF (R1 = 1) THEN GOTO:BOREPROBE
#IF (R1 = 2) THEN GOTO:BOSSPROBE

#:BOREPROBE
#R5 = (R3/2.0)*V13 'Movement radius distance with overtravel factor
(Position 1 at 0 degrees)
#R6 = V20 + R5
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P1
#WAIT
(Position 2 at 240 degrees)
#R6 = V20 + (R5 * cos(240))
#R7 = V21 + (R5 * sin(240))
L9101 R1+1. X+R6. Y+R7. F+R4. P2
#WAIT
(Position 3 at 120 degrees)
#R6 = V20 + (R5 * cos(120))
#R7 = V21 + (R5 * sin(120))
L9101 R1+1. X+R6. Y+R7. F+R4. P3
#WAIT
(Calculate Center)
L9101 R1+2. (COMPUTE CENTER)
#WAIT
#FX(V2) = R1
#FY(V2) = R2
G1 G31 F+R4 X+R1 Y+R2 (Move to center)
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Center X: ", R1, " Center Y: ", R2
#PRINT "PRESS ENTER TO EXIT"
#INPUT V99
#GOTO:END

#:BOSSPROBE
(Place probe at center of boss above about 1/4 inch)
#R8 = V22 - V15 'Z probing height for boss use
#R9 = V22 'Z safe height
#R5 = (R3/2.0)*V14 'Movement radius distance with overtravel factor
(Position 1 0 degrees)
#R6 = V20 + R5
#R7 = V21
G1 G31 X+R6. Y+R7. F+R4. P1
G1 G31 F+R4 Z+R8 (Move to Z height)
#WAIT
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P1 (Move back to center)
G1 G31 F+R4 Z+R9 (Return to safe Z height)
G1 G31 F+R4 X+R6 Y+R7 (Move to center)
#WAIT
(Position 2, 240 degrees)
#R6 = V20 + (R5 * cos(240))
#R7 = V21 + (R5 * sin(240))
G1 G31 X+R6. Y+R7. F+R4. P2
G1 G31 F+R4 Z+R8 (Move to Z height)
#WAIT
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P2 (Move back to center)
#WAIT
G1 G31 F+R4 Z+R9 (Return to safe Z height)
G1 G31 F+R4 X+R6 Y+R7 (Move to center)
#WAIT
(Position 3, 120 degrees)
#R6 = V20 + (R5 * cos(120))
#R7 = V21 + (R5 * sin(120))
G1 G31 X+R6. Y+R7. F+R4. P3
G1 G31 F+R4 Z+R8 (Move to Z height)
#WAIT
#R6 = V20
#R7 = V21
L9101 R1+1. X+R6. Y+R7. F+R4. P3 (Move back to center)
#WAIT
G1 G31 F+R4 Z+R9 (Return to safe Z height)
G1 G31 F+R4 X+R6 Y+R7 (Move to center)
#WAIT
(Calculate Center)
L9101 R1+2. (COMPUTE CENTER)
#WAIT
#FX(V2) = R1
#FY(V2) = R2
G1 G31 F+R4 X+R1 Y+R2 (Move to center)
#PRINT " "
#PRINT " "
#PRINT " "
#PRINT "Center X: ", R1, " Center Y: ", R2
#PRINT "PRESS ENTER TO EXIT"
#INPUT V99
#GOTO:END

#:FAULT
#PRINT "Probekit Fault, Input Faulty"
#GOTO:END

#:END
M67 (Turn Off Probe)
M99
