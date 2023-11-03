# Counting and Displaying the Number of Files and Folders in A Specific Path #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


while true

	print "\nEnter Folder Name (Enter * to Exit): "		# A Folder or File Path to Be Checked
	path = STDIN.gets().chomp.tr('""', '')				# Getting the Path and Removing "" Chars by Trimming If the Path Has Any of It
	path = path.gsub(/\\/, '/')							# All the "\" Chars in the Path will Be Changed to "/" for Windows
	
	if path == "*"
		exit
	end
	
	if path.rpartition("/").first == ""					# If Only A Folder Name is Written Instead of A Full Path
		path = "./" + path								# Making It A Full Path with the Working Directory: "./"
	end
	
	# Now It must Be Checked If This Folder Exists
	print "\n#{path}\n"
	if Dir.exist?(path) or File.file?(path)
		break
	else
		print "No Such Folder or File Exists!\n"
		next
	end
	
end


filecount = 0
foldercount = 0

if File.file?(path)
	print "This is A File!\n"
	filecount = filecount + 1
	
else
	print "This is A Folder!\n"
	Dir.foreach(path) do |name|
		next if name == '.' or name == '..'
		
		if File.file?(path + "/" + name)
			filecount = filecount + 1
		else
			foldercount = foldercount + 1
		end
		
	end
end

# Displaying the Number of Files and Folders in the Path Given from Input
print "\nFolders: #{foldercount}\n"
print "Files:   #{filecount}\n"


continue