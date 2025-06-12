require_relative 'models/student'

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