class Question

  NOT_ALLOWED ="The question is addressed to another person"
  
  def initialize questioner
    @questioner = questioner
    @replied = false
    @addressed_to = nil
  end

  def whose
    @questioner
  end

  def replied?
    @replied
  end

  def reply by
    raise NOT_ALLOWED unless allowed_to_reply? by 
    @replied = true
  end

  def whom
    @addressed_to
  end

  def address person
    @addressed_to = person
  end
  
  private 
  
  def not_addressed?
    @addressed_to.nil?
  end

  def allowed_to_reply? by
    (@addressed_to == by) || not_addressed?
  end
end
