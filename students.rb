puts "Welcome, loading data... *.csv"

File.open('data.csv', 'r') do |file| 
    data = file.readlines.map(&:chomp)
    students = [] 
    data.each do |student, i|
        students.push(student.split(', '))
    end

    def average(student_name, score)
        file = File.open(student_name, 'w')
        file.puts score
        file.close
    end
    
    def check_approved(minimum_mark=2)
        students.each do |student|
            addition = 0
            student.drop(1).each do |calification|
                number = calification.to_i
                addition += number
            end
            average = addition/5
            puts "Student #{student[0]} approved with average: #{average}" if average > minimum_mark
        end
    end
     

opcion = 0
while opcion != 4 do

puts "\nChoose your option:"
print "[1] Resumes - [2] Absences - [3] Approved students - [4] Exit\n"

    option = gets.chomp.to_i
    case option
        when 1
            puts "Generating student's average..."
            students.each do |student|
                addition = 0
                student.drop(1).each do |calification|
                    number = calification.to_i
                    addition += number
                end
                puts "Student: #{student[0]} / Average: #{addition/5}"
                average(student[0], addition/5)
            end

        when 2
            puts "Generating student's absences..."
            total = 0
            students.each do |student|
                count = 0
                student.drop(1).each do |absence|
                    count += 1 and total += 1 if absence == 'A'
                end
                puts "Student: #{student[0]} / Absence: #{count}"
            end
            puts "Total Absences: #{total}"

        when 3
            puts "Generating approved students..."
            check_approved
        end    
    end

end
