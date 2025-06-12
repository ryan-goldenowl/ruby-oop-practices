#Module display infomation
module InfoDisplay
  def display_info
  end
end

# Subject base class
class Subject
  include InfoDisplay
  attr_accessor :name, :grade, :weight

  def initialize(name, grade, weight = 1.0)
    @name = name
    @grade = grade
    @weight = weight
  end
  
  def display_info
    puts " - Subject: #{@name}, Grade: #{@grade}, Weight: #{@weight}"
  end

  def passed?
    grade.to_f >= 5.0
  end
end

# Specific subjects
class Mathematics < Subject
  def initialize(grade = nil)
    super("Mathematics", grade, 2.0)
  end
end

class Literature < Subject
  def initialize(grade = nil)
    super("Literature", grade, 2.0)
  end
end

class Science < Subject
  def initialize(grade = nil)
    super("Science", grade, 1.5)
  end
end

class Chemistry < Subject
  def initialize(grade = nil)
    super("Chemistry", grade, 1.5)
  end
end

class Biology < Subject
  def initialize(grade = nil)
    super("Biology", grade, 1.5)
  end
end

class History < Subject
  def initialize(grade = nil)
    super("History", grade, 1.0)
  end
end

class Geography < Subject
  def initialize(grade = nil)
    super("Geography", grade, 1.0)
  end
end


# Student class
class Student 
  include InfoDisplay
  attr_accessor :name, :subjects

  def initialize(name)
    @name = name
    @subjects = []
  end

  def add_subject(subject)
    existing = @subjects.find do |s|
      s.name == subject.name
    end
    
    if existing
      existing.grade = subject.grade
    else
      @subjects << subject
    end
  end

  def display_info
    puts "\n#{@name}'s Subjects:\n"
    if @subjects.empty?
      puts "- No subjects added."
    else
      @subjects.each do |subject|
        print subject.display_info  
      end
    end
  end

  def average_score
    total_weight = @subjects.sum(&:weight)
    return 0 if total_weight == 0
    total_score = @subjects.sum do |s| 
      s.grade.to_f * s.weight 
    end

    (total_score / total_weight).round(2)
  end

  def passed_subjects
    @subjects.select(&:passed?)
  end

  def failed_subjects
    @subjects.reject(&:passed?)
  end
end

class StudentManager
  attr_accessor :students

  def initialize
    @students = []
  end

  def add_student(name)
    @students << Student.new(name)
  end

  def find_student(name)
    @students.find { |s| s.name.downcase == name.downcase }
  end

  def list_all_students
    @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student.name} (Avg: #{student.average_score})"
    end
  end

  def best_student
    @students.max_by do |student|
      student.average_score
    end
  end
end



manager = StudentManager.new

# Seed data
ryan = Student.new("Ryan")
ryan.add_subject(Mathematics.new(8.5))
ryan.add_subject(Literature.new(7.0))
ryan.add_subject(Science.new(9.0))
ryan.add_subject(Chemistry.new(6.5))
ryan.add_subject(Biology.new(5.0))
ryan.add_subject(History.new(4.0))
ryan.add_subject(Geography.new(7.5))

zane = Student.new("Zane")
zane.add_subject(Mathematics.new(9.0))
zane.add_subject(Literature.new(8.0))
zane.add_subject(Science.new(7.5))
zane.add_subject(Chemistry.new(6.0))      

lily = Student.new("Lily")
lily.add_subject(Mathematics.new(5.5))
lily.add_subject(Literature.new(6.0))
lily.add_subject(Science.new(7.0))
lily.add_subject(Chemistry.new(8.0))
lily.add_subject(Biology.new(9.0))

hector = Student.new("Hector")
hector.add_subject(Mathematics.new(4.0))
hector.add_subject(Literature.new(5.0))
hector.add_subject(Science.new(6.0))
hector.add_subject(Chemistry.new(7.0))
hector.add_subject(Biology.new(8.0))

kai = Student.new("Kai")
kai.add_subject(Mathematics.new(10.0))
kai.add_subject(Literature.new(9.5))
kai.add_subject(Science.new(8.0))
kai.add_subject(Chemistry.new(7.5))
kai.add_subject(Biology.new(6.0))
kai.add_subject(History.new(5.0))
kai.add_subject(Geography.new(4.5))

manager.students = [ryan, zane, lily, hector, kai]


# =====Main Program=====
loop do
  system("clear")
  puts "
  =========================
  Student Management System
  =========================
  1. Add student
  2. Add subject to student
  3. Update grade
  4. Display student info
  5. List all students
  6. Show best student
  0. Exit
  ========================="
  print "Choose: "
  choice = gets.to_i

  case choice
  when 1
    system("clear")
    print "Enter student name: "
    name = gets.chomp
    manager.add_student(name)
    puts "#{name} added."

  when 2
    system("clear")
    print "Student name: "; name = gets.chomp
    student = manager.find_student(name)

    if student
      puts "Choose subject:
      1. Math
      2. Literature
      3. Science
      4. Chemistry
      5. Biology
      6. History
      7. Geography"
      sub_choice = gets.to_i

      print "Enter grade (0 - 10): "; grade = gets.to_f

      if grade < 0 || grade > 10
        puts "\nGrade must be between 0 and 10. Subject not added."
      else
        subject = case sub_choice
                  when 1 then Mathematics.new(grade)
                  when 2 then Literature.new(grade)
                  when 3 then Science.new(grade)
                  when 4 then Chemistry.new(grade)
                  when 5 then Biology.new(grade)
                  when 6 then History.new(grade)
                  when 7 then Geography.new(grade)
                  else nil
                  end

        if subject
          student.add_subject(subject)
          puts "Subject added!"
        else
          puts "Invalid subject!"
        end
      end
    else
      puts "Student not found!"
    end

  when 3
    system("clear")
    print "Student name: "; name = gets.chomp
    student = manager.find_student(name)
    if student
      puts "Choose subject to update:"
      puts "1. Math
            2. Literature
            3. Science
            4. Chemistry
            5. Biology
            6. History
            7. Geography"
      sub_choice = gets.to_i

      subject_name = case sub_choice
                     when 1 then "Math"
                     when 2 then "Literature"
                     when 3 then "Science"
                     when 4 then "Chemistry"
                     when 5 then "Biology"
                     when 6 then "History"
                     when 7 then "Geography"
                     else nil
                     end

      if subject_name
        print "Enter new grade (0 - 10): "; grade = gets.to_f
        if grade < 0 || grade > 10
          puts "\nGrade must be between 0 and 10. Grade not updated."
        else
          subject = case sub_choice
                    when 1 then Mathematics.new(grade)
                    when 2 then Literature.new(grade)
                    when 3 then Science.new(grade)
                    when 4 then Chemistry.new(grade)
                    when 5 then Biology.new(grade)
                    when 6 then History.new(grade)
                    when 7 then Geography.new(grade)
                    end
          student.add_subject(subject)
          puts "Subject updated!"
        end
      else
        puts "Invalid subject!"
      end
    else
      puts "Student not found!"
    end

  when 4
    system("clear")
    print "Student name: "; name = gets.chomp
    student = manager.find_student(name)
    if student
      student.display_info
      puts "Average Score: #{student.average_score}"
      puts "Passed Subjects: #{student.passed_subjects.map(&:name).join(', ')}"
      puts "Failed Subjects: #{student.failed_subjects.map(&:name).join(', ')}"
    else
      puts "Student not found."
    end

  when 5
    system("clear")
    manager.list_all_students

  when 6
    system("clear")
    best = manager.best_student
    if best
      puts "Best Student: #{best.name} - Avg Score: #{best.average_score}"
    else
      puts "No students found."
    end

  when 0
    system("clear")
    puts "Exiting..."
    sleep(1.5)
    system("clear")
    break

  else
    system("clear")
    puts "Invalid choice."
  end

  puts "\nPress Enter to continue..."
  gets
end




