# Checking File Existence #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


print "\nEnter Filename (Enter * to Exit): "
path = STDIN.gets().chomp.tr('""', '')
if path == "*"
	exit
end
path = path.gsub(/\\/, '/')					# All the "\" Chars in the Path will Be Changed to "/" for Windows.
if path.rpartition("/").first == ""			# If Only A Folder Name is Written Instead of A Full Path
	path = "./" + path						# Making It A Full Path with the Working Directory: "./"		
end

print "\n#{path}\n"
if File.file?(path)
	print "The File Exists!\n"
else
	print "No Such File Exists!\n"
end


continue