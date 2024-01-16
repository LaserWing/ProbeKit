%
N0 O9999 (CUSTOM MACRO CHOOSER)
#PRINT ""
#PRINT ""
#PRINT "Select Macro:"
#PRINT "0: Haimer Helper Set Axis at Fixture Offset"
#PRINT "1: Probe Helper"
#PRINT "Enter Selection Number:"
#INPUT V10
#IF V10 = 0 THEN START 9200
#IF V10 = 1 THEN START 9100
