# Deleting Files in A Folder by the Reference of Filenames in Another Folder #

require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


while true

	print "\nDeletion Path (Enter * to Exit): "		# The Folder of Files That will Be Deleted If the Reference Path Has any Files with the Same Names
	del_path = STDIN.gets().chomp.tr('""', '')		# Getting the Path and Removing "" Chars by Trimming If the Path Has Any of It
	del_path = del_path.gsub(/\\/, '/')				# All the "\" Chars in the Path will Be Changed to "/" for Windows
	
	if del_path == "*"
		exit
	end
	
	if del_path.rpartition("/").first == ""			# If Only A Folder Name is Written Instead of A Full Path
		del_path = "./" + del_path					# Making It A Full Path with the Working Directory: "./"
	end
	
	# Now It must Be Checked If This Folder Exists
	print "\n#{del_path}\n"
	if Dir.exist?(del_path)
		break
	else
		print "No Such Folder Exists!\n"
		next
	end
	
end


while true

	print "\nReference Path (Enter * to Exit): "	# The Names of Files in the Reference Path will Specify which Files will Be Deleted from the Deletion Path
	ref_path = STDIN.gets().chomp.tr('""', '')		# Getting the Path and Removing "" Chars by Trimming If the Path Has Any of It
	ref_path = ref_path.gsub(/\\/, '/')				# All the "\" Chars in the Path will Be Changed to "/" for Windows
	
	if ref_path == "*"
		exit
	end
	
	if ref_path.rpartition("/").first == ""			# If Only A Folder Name or Filename is Written Instead of A Full Path
		ref_path = "./" + ref_path					# Making It A Full Path with the Working Directory: "./"
	end
	
	# Now It must Be Checked If This Folder or File Exists (Reference can also Be A File!)
	print "\n#{ref_path}\n"
	if Dir.exist?(ref_path) or File.file?(ref_path)
		break
	else
		print "No Such Folder or File Exists!\n"
		next
	end
	
end

ref_var = ref_path.rpartition("/").last

count = 0										# How Many Files will Be Deleted in Total

if File.file?(ref_path)							# If the Reference Path Belongs to A Single File
	Dir.foreach(del_path) do |del_name|
		next if del_name == '.' or del_name == '..' or not File.file?(del_path + "/" + del_name)		# Folders in Deletion Path will Not Be Included.

		if del_name == ref_var
			File.delete(del_path + "/" + del_name)
			count = count + 1
			break
		end

	end

else											# If the Reference Path Belongs to A Folder
	Dir.foreach(ref_path) do |ref_name|
		next if ref_name == '.' or ref_name == '..' or not File.file?(ref_path + "/" + ref_name)		# Folders in Reference Path will Not Be Included
		
		Dir.foreach(del_path) do |del_name|
			next if del_name == '.' or del_name == '..' or not File.file?(del_path + "/" + del_name)	# Folders in Deletion Path will Not Be Included

			if del_name == ref_name
				File.delete(del_path + "/" + del_name)
				count = count + 1
				break
			end

		end
	end
end

del_root = del_path.rpartition("/").first
print "\n#{count} Files are Deleted from: #{del_path}\n"


continue