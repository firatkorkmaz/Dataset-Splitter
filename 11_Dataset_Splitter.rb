# Copying Dataset Folders by Distributed File Selections #

require 'fileutils'
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


src_var = src_path.rpartition("/").last			# Extract the Source Folder's Name from the Input Path
src_root = src_path.rpartition("/").first		# Extract the Root Path of the Soruce Folder from the Input Path

src_var = src_var + "_"							# Adding the First "_" Symbol at the End of the Source Folder's Name which will Be the Name of New Data Folder

while true

	if Dir.exist?(src_root + "/#{src_var}")		# Adding An Additional "_" Symbol to the End of New Data Folder's Name...
		src_var = src_var + "_"					# ...as Long as A Folder with the Same Name Already Exists in the Root Path
	else
		break
	end

end


dest_path = src_root + "/#{src_var}"			# Destination Path for Creating the Subfolders is Set to Copy the Data Files

while true
	print "\nHow many Files per Subfolder to Copy/Move\nEnter A Positive Number (Enter * to Exit): "
	copynumber = STDIN.gets().chomp
	
	if copynumber == "*"
		exit
	end
	
	copynumber = copynumber.to_i
	
	if copynumber <= 0
		print "You must Enter A Positive Number!\n"
		next
	else
		temp_copynumber = copynumber
		break
	end

end


while true

	print "\nFile Selection Mode\n"
	print "Regular from the Head: 1\n"		# For Selecting Files Sequentially from the Head to the End
	print "Distributed Selection: 2\n"		# For Selecting Files in A Distributed Way
	print "Regular from the End : 3\n"		# For Selecting Files Sequentially from the End to the Head
	print "Random from Anywhere : 4\n"		# For Selecting Files Randomly from Anywhere of the File List (Different for Each Subfolder)
	print "(Enter * to Exit Program)\n"
	print "Your Selection: "
	selection = STDIN.gets().chomp
	
	if selection == "*"
		exit
	end
	
	selection = selection.to_i				# If the Input Has A Non-Numeric Char, This Process will Give 0 Value
	
	if selection <= 0 or selection > 4
		print "You must Enter 1, 2, 3 or 4!\n"
		next
	elsif selection == 1 or selection == 2 or selection == 3 or selection == 4
		break
	end
	
end


while true

	print "\nCopy or Move Files?\n"
	print "Copy Files to New Folders: 1\n"
	print "Move Files to New Folders: 2\n"
	print "(Enter * to Exit Program)\n"
	print "Your Selection: "
	copy_move = STDIN.gets().chomp
	
	if copy_move == "*"
		exit
	end
	
	copy_move = copy_move.to_i				# If the Input Has A Non-Numeric Char, This Process will Give 0 Value
	
	if copy_move <= 0 or copy_move > 2
		print "You must Enter 1 or 2!\n"
		next
	elsif copy_move == 1 or copy_move == 2
		break
	end
	
end


totalfilecount = 0
subfoldercount = 0
Dir.mkdir(dest_path)
print "\nNew Data Folder Created: #{dest_path}\n\n"


if selection == 1			# Files are Selected Regularly to Copy by Starting from the First File and Continuing One by One
	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or File.file?(src_path + "/#{src_name}")
		
		Dir.mkdir(dest_path + "/#{src_name}") and subfoldercount = subfoldercount + 1 unless Dir.exist?(dest_path + "/#{src_name}")
		
		filecount = 0
		Dir.foreach(src_path + "/#{src_name}") do |file_name|
			next if file_name == '.' or file_name == '..' or not File.file?(src_path + "/#{src_name}" + "/#{file_name}")
			FileUtils.cp(src_path + "/#{src_name}" + "/#{file_name}", dest_path + "/#{src_name}")
			if copy_move == 2
				File.delete(src_path + "/#{src_name}" + "/#{file_name}")		# Copy or Move Files!
			end
			filecount = filecount+1
			if filecount >= copynumber
				break
			end
		end
		totalfilecount = totalfilecount + filecount
		print "Total Files Copied: #{totalfilecount}\n"
	end

elsif selection == 2		# Files are Selected in A Distributed Way According to the Specified Number of Files to Copy
	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or File.file?(src_path + "/#{src_name}")
		
		Dir.mkdir(dest_path + "/#{src_name}") and subfoldercount = subfoldercount + 1 unless Dir.exist?(dest_path + "/#{src_name}")	# Creating New Subfolder
		
		filecountbyfolder = Dir.glob(File.join(src_path + "/#{src_name}", '**', '*')).select { |file| File.file?(file) }.count	# File Count in Source Subfolder
		if copynumber > filecountbyfolder
			copynumber = filecountbyfolder
		end
		
		iterator = (filecountbyfolder+1) / (copynumber)						# Step Number to Select the Next File Everytime to Copy
		startindex = ( (filecountbyfolder)-((copynumber-1)*iterator+1) )/2	# Centering Selection List by Setting Non-Selected File Counts from both Sides Equal
		
		filecount = 0
		tempfilecount = 0
		Dir.foreach(src_path + "/#{src_name}") do |file_name|
			next if file_name == '.' or file_name == '..' or not File.file?(src_path + "/#{src_name}" + "/#{file_name}")
			
			if tempfilecount >= startindex and (tempfilecount-startindex) % iterator == 0
				FileUtils.cp(src_path + "/#{src_name}" + "/#{file_name}", dest_path + "/#{src_name}")
				if copy_move == 2
					File.delete(src_path + "/#{src_name}" + "/#{file_name}")	# Copy or Move Files!
				end
				filecount = filecount+1										# Copied File Counts for Each Subfolder
			end
			if filecount >= copynumber										# Only the Specified Number of Files Per Subfolder will Be Copied
				break
			end
			tempfilecount = tempfilecount+1									# Iteration Variable to Find Which File to Copy
		end
		totalfilecount = totalfilecount + filecount							# Total Number of Copied Files for All the Processed Subfolders
		print "Total files copied: #{totalfilecount}\n"
		copynumber = temp_copynumber
	end

elsif selection == 3						# Files are Selected Regularly to Copy by Starting from the First File and Continuing One by One
	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or File.file?(src_path + "/#{src_name}")
		
		Dir.mkdir(dest_path + "/#{src_name}") and subfoldercount = subfoldercount + 1 unless Dir.exist?(dest_path + "/#{src_name}")
		filecountbyfolder = Dir.glob(File.join(src_path + "/#{src_name}", '**', '*')).select { |file| File.file?(file) }.count	# File Count in Source Subfolder

		if filecountbyfolder-copynumber < 0
			limit = 0
		else
			limit = filecountbyfolder-copynumber
		end
		
		filecount = 0
		skipcount = 0
		Dir.foreach(src_path + "/#{src_name}") do |file_name|			
			next if file_name == '.' or file_name == '..' or not File.file?(src_path + "/#{src_name}" + "/#{file_name}")
			if skipcount < limit
				# No Copying
				skipcount = skipcount+1
				next
			else
				FileUtils.cp(src_path + "/#{src_name}" + "/#{file_name}", dest_path + "/#{src_name}")
				if copy_move == 2
					File.delete(src_path + "/#{src_name}" + "/#{file_name}")		# Copy or Move Files!
				end
				filecount = filecount+1
			end
		end
		totalfilecount = totalfilecount + filecount
		print "Total Files Copied: #{totalfilecount}\n"
	end

else												# Files are Selected Randomly from Anywhere of the File List for Each Subfolder to Copy
	Dir.foreach(src_path) do |src_name|
		next if src_name == '.' or src_name == '..' or File.file?(src_path + "/#{src_name}")
		
		Dir.mkdir(dest_path + "/#{src_name}") and subfoldercount = subfoldercount + 1 unless Dir.exist?(dest_path + "/#{src_name}")
		
		filecountbyfolder = Dir.glob(File.join(src_path + "/#{src_name}", '**', '*')).select { |file| File.file?(file) }.count	# File Count in Source Subfolder
		random_list = [*0..filecountbyfolder-1].sample(copynumber).sort				# Creating A Sorted Random Index List by the Copy Number for Each Subfolder
		
		iter = 0
		filecount = 0
		Dir.foreach(src_path + "/#{src_name}") do |file_name|
			next if file_name == '.' or file_name == '..' or not File.file?(src_path + "/#{src_name}" + "/#{file_name}")
			if random_list[filecount] == iter                                       # If the File Index is Included in the Randomly Created & Sorted Index List
				FileUtils.cp(src_path + "/#{src_name}" + "/#{file_name}", dest_path + "/#{src_name}")
				if copy_move == 2
					File.delete(src_path + "/#{src_name}" + "/#{file_name}")		# Copy or Move Files!
				end
				filecount = filecount+1
				if filecount >= copynumber								# Stop Iteration for the Current Subfolder If the Required Number of Files are Copied
					break
				end
			end
			iter = iter+1
		end
		totalfilecount = totalfilecount + filecount
		print "Total Files Copied: #{totalfilecount}\n"
	end

end


print "\n#{subfoldercount} Subfolders Created in: #{dest_path}\n"
if copy_move == 1
	print "\n#{totalfilecount} Files Copied...\nfrom: #{src_path}\nto:   #{dest_path}\n"
else
	print "\n#{totalfilecount} Files Moved...\nfrom: #{src_path}\nto:   #{dest_path}\n"
end


continue