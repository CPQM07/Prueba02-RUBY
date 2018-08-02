public def cyan; "\e[36m#{self}\e[0m" end
public def red; "\e[31m#{self}\e[0m" end
public def green; "\e[32m#{self}\e[0m" end

#read file
puts "Welcome, loading data... *.csv"
@students = [] 
File.open('data.csv', 'r') do |file| 
    data = file.readlines.map(&:chomp)
    data.each do |student, i|
        @students.push(student.split(', '))
    end
end
#end read file

#puts students

#methods 
def average(student_name, score)
    file = File.open(student_name, 'w')
    file.puts "The student #{student_name} has an average of: #{score}"
    file.close
end

def check_approved(minimum_mark=nil)
    puts "The minimum mark was set in: #{minimum_mark}"
    @students.each do |student|
        addition = 0
        student.drop(1).each do |calification|
            number = calification.to_i
            addition += number
        end
        average = addition/5
        puts "Student #{student[0]} approved with average: #{average}" if average > minimum_mark
    end
end
#end methods

#menu
option = 0
while option != 4 do
    puts "\nChoose your option:".red
    print "[1] Resumes - [2] Absences - [3] Approved students - [4] Exit\n".green
    option = gets.chomp.to_i
    case option
        when 1
            puts "Generating student's average...".cyan
            @students.each do |student|
                addition = 0
                student.drop(1).each do |calification|
                    number = calification.to_f
                    addition += number
                end
                puts "Student: #{student[0]} / Average: #{addition/5}".cyan
                average(student[0], addition/5).cyan
            end
        when 2
            puts "Generating student's absences...".cyan
            total = 0
            @students.each do |student|
                count = 0
                student.drop(1).each do |absence|
                    count += 1 and total += 1 if absence == 'A'
                end
                puts "Student: #{student[0]} / Absence: #{count}".red
            end
            puts "Total Absences: #{total}".red

        when 3
            puts "Generating approved students...".cyan
            puts "Please give us a number"
            number = gets.chomp.to_i
            check_approved(number).green
        
        when 4
            puts "Thanks, see you later"
        end
    end
#end menu
