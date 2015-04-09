class Question

  NOT_ALLOWED ="The question is addressed to another person"
  UNANSWERED = 'must be answered before'
  NOT_QUESTIONER = 'must be accepted by the questioner'
  
  def initialize questioner
    @questioner = questioner
    @state = :asked
    @addressed_to = nil
  end

  def whose
    @questioner
  end

  def answered?
    @state == :answered || accepted?
  end

  def answer by
    raise NOT_ALLOWED unless allowed_to_answer? by 
    @state = :answered
  end

  def whom
    @addressed_to
  end

  def address person
    @addressed_to = person
  end

  def accepted?
    @state == :accepted
  end

  def unaccepted?
    !accepted?
  end

  def accept by
    raise UNANSWERED unless answered?
    raise NOT_QUESTIONER unless questioner? by
    @state = :accepted
  end
  
  private 
  
  def not_addressed?
    @addressed_to.nil?
  end

  def allowed_to_answer? person
    (@addressed_to == person) || not_addressed?
  end

  def questioner? person
    person == @questioner
  end
end
