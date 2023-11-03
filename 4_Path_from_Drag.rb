# Printing File-Folder Path from Dragging #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


print "\nDrag File/Folder to Extract Its Full Path: "
path = STDIN.gets().chomp.tr('""', '')
path = path.gsub(/\\/, '/')					# All the "\" Chars in the Path will Be Changed to "/" for Windows.
if path.rpartition("/").first == ""
	path = "./" + path
end

print "\nFull Path:   #{path}\n"

file_folder = path.rpartition("/").last.rpartition("\\").last
print "File/Folder: #{file_folder}\n"


continue