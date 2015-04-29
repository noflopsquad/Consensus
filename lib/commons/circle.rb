class Circle
  def initialize
    @members = Array.new
  end

  def involve who
    @members.push who
  end

  def involved? who
    @members.include? who
  end
end
