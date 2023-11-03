# A Simple Program to Show Distributed Selections from A Set of Numbers #

require 'fileutils'
require 'io/console'

def continue
	print "\n\n-------------\n"
	print "Press any key to continue..."
	STDIN.getch
	print "\n"
end


print "\nRandom Selection Program\n"


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


filecount = 20
random_list = [*1..totalcount].sample(copynumber).sort

print "\nSorted Random Selections:\n"
for i in 0..copynumber-1

	print "#{random_list[i]} "

end
print "\n"


continue