%
O9200 (ProbeKit SetAxis)
(For use with a Haimer 3D Taster)
(Choose axis, enter fixture offset number, set fixture offset to current position)
(Z Axis will use tool 99 as height reference)

#V10 = 0 'Fixture offset storage
#V11 = 0 'Axis selection storage
#V50 = 0 'Position storage

#PRINT "Select Axis: X=1, Y=2, Z=3"
#INPUT V10 'Axis selection
#IF V11 = 1 THEN GOTO :XAXIS
#IF V11 = 2 THEN GOTO :YAXIS
#IF V11 = 3 THEN GOTO :ZAXIS

#:XAXIS
#V50 = AX
#PRINT "Current X position:", V50
#PRINT "Enter E fixture offset number (1-48):"
#INPUT V10 'Fixture offset number
#IF V10 < 1 THEN GOTO :ERROR
#IF V10 > 48 THEN GOTO :ERROR
#PRINT "Setting X value of E", V10, " to", V50
#FX(V10) = V50
#PRINT "X value for E", V10, " set to", FX(V10)
#GOTO :END

#:YAXIS
#V50 = AY
#PRINT "Current Y position:", V50
#PRINT "Enter E fixture offset number (1-48):"
#INPUT V10 'Fixture offset number
#IF V10 < 1 THEN GOTO :ERROR
#IF V10 > 48 THEN GOTO :ERROR
#PRINT "Setting Y value of E", V10, " to", V50
#FY(V10) = V50
#PRINT "Y value for E", V10, " set to", FY(V10)
#GOTO :END

#:ZAXIS
#IF H99 < 0 THEN GOTO :ERROR2
#IF H99 = 0 THEN GOTO :ERROR2
#V50 = AZ - H99
#PRINT "Current Z position with Tool 99:", V50
#PRINT "Enter E fixture offset number (1-48):"
#INPUT V10 'Fixture offset number
#IF V10 < 1 THEN GOTO :ERROR
#IF V10 > 48 THEN GOTO :ERROR
#PRINT "Setting Z value of E", V10, " to", V50
#FZ(V10) = V50
#PRINT "Z value for E", V10, " set to", FZ(V10)
#GOTO :END

#:ERROR
#PRINT "ERROR:"
#PRINT "Fixture offset invalid."
#GOTO :END

#:ERROR2
#PRINT "ERROR:"
#PRINT "ERROR:"
#PRINT "Reference Tool (Tool 99) length is invalid."
#PRint "Reference Tool (Tool 99) must be positive length."
#GOTO :END

#:END
M30
%
