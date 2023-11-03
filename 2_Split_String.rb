# Splitting Strings #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


arr = "dat.filename.txt"
print "\nFull String:        #{arr}\n"

split_by_left = arr.partition(".")
print "Split by . [Left]:  #{split_by_left}\n"

split_by_right = arr.rpartition(".")
print "Split by . [Right]: #{split_by_right}\n"

filename = arr.partition(".").last.rpartition(".").first
print "Filename in String: #{filename}\n"

filename = arr.rpartition(".").first.partition(".").last
print "Filename in String: #{filename}\n"


continue