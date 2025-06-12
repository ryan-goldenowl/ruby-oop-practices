require_relative 'info_display'

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