# Calling the Function: "Press any key to continue . . . #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


continue