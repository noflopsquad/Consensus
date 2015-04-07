class Question

  NOT_ALLOWED ="The question is addressed to another person"
  
  def initialize questioner
    @questioner = questioner
    @answered = false
    @addressed_to = nil
  end

  def whose
    @questioner
  end

  def answered?
    @answered
  end

  def answer by
    raise NOT_ALLOWED unless allowed_to_answer? by 
    @answered = true
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

  def allowed_to_answer? person
    (@addressed_to == person) || not_addressed?
  end
end
