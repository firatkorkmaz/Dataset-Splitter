# Trimming Strings #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


raw = "((String))"
print "\nRaw String: #{raw}\n"
trimmed = raw.tr('()', '')
print "Trimmed String: #{trimmed}\n"


continue