class Phase

  def initialize denomination
    @denomination=denomination
  end
  def to_s
    @denomination
  end
  def next
    self
  end
end

class Introduction<Phase
  MINIMUM_TIME = 2
  SECONDS_IN_A_DAY = (24*60*60)

  def initialize 
    @denomination='Introduction'
    calculate_expiration
  end

  def next
    check_ready_to_change
    FirstLevel.new
  end

  private 
  
  def check_ready_to_change
    raise MinimumDurationNotReached.new unless minimum_time_has_passed?
  end

  def minimum_time_has_passed?
    Time.now.to_i >= @expiration_time
  end

  def calculate_expiration
    @expiration_time = Time.now.to_i + (MINIMUM_TIME * SECONDS_IN_A_DAY)
  end

end



class FirstLevel<Phase
  def initialize 
    @denomination='First discussion level'
  end
end