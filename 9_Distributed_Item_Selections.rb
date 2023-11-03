# A Simple Program to Show Distributed Selections from A Set of Numbers #

require 'fileutils'
require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


print "\nDistributed Selection Program\n"


while true
	print "\nEnter Number of Items (Enter * to Exit): "
	totalcount = STDIN.gets().chomp
	
	if totalcount == "*"
		exit
	end
	
	totalcount = totalcount.to_i
	
	if totalcount <= 0
		print "You must Enter A Positive Number!\n"
		next
	else
		break
	end
end

while true
	print "\nEnter Number of Selection (Enter * to Exit): "
	copynumber = STDIN.gets().chomp

	if copynumber == "*"
		exit
	end
	
	copynumber = copynumber.to_i
	
	if copynumber <= 0
		print "You must Enter A Positive Number!\n"
		next
	else
		break
	end
end
	
	
print "\nTotal Numbers:\n"

for i in 1..totalcount
   print "#{i} "
end
print "\n"

iterator = (totalcount+1) / (copynumber)
startindex = ( (totalcount)-((copynumber-1)*iterator+1) )/2

count = 0
tempcount = 0
print "\nDistributed Selections:\n"
for i in 1..totalcount

	if tempcount >= startindex and (tempcount-startindex) % iterator == 0
		print "#{i} "
		count = count+1
	end
	
	if count >= copynumber
		break
	end
	tempcount = tempcount+1

end
print "\n"


continue