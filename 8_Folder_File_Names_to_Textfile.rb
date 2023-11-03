# Writing the List of Folder-File Names in A Path to A Textfile #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


while true

	print "\nEnter Folder Name (Enter * to Exit): "
	src_path = STDIN.gets().chomp.tr('""', '')		# Getting the Path and Removing "" Chars by Trimming If the Path Has Any of It
	src_path = src_path.gsub(/\\/, '/')				# All the "\" Chars in the Path will Be Changed to "/" for Windows
	
	if src_path == "*"
		exit
	end
	
	if src_path.rpartition("/").first == ""			# If Only A Filename is Written Instead of A Full Path
		src_path = "./" + src_path					# Making It A Full Path with the Working Directory: "./"
	end
	
	# Now It must Be Checked If This Folder Exists
	print "\n#{src_path}\n"
	if Dir.exist?(src_path)
		break
	else
		print "No Such Folder Exists!\n"
		next
	end
	
end


filecount = 0
foldercount = 0
file = File.open("./pathlist.txt", "w+")

if File.file?(src_path)
	file.write("--------\n")
	file.write("#{src_path.rpartition("/").last}\n")
	filecount = filecount + 1

else
	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or File.file?(src_path + "/" + src_name)
		file.write("#{src_name}\n")
		foldercount = foldercount + 1
	end

	file.write("--------\n")			# Writing A Line in the Textfile Between the Foldername List and the Filename List

	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or not File.file?(src_path + "/" + src_name)
		file.write("#{src_name}\n")
		filecount = filecount + 1
	end
end

file.close

print "\n#{foldercount} Folder Names and #{filecount} Filenames are Written in: pathlist.txt\n"


continue