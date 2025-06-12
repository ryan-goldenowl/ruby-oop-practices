require_relative 'info_display'
require_relative 'subject'

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