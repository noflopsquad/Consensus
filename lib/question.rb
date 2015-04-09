class Question

  NOT_ALLOWED ="The question is addressed to another person"
  UNANSWERED = 'must be answered before'
  NOT_QUESTIONER = 'this action must be made by the questioner'
  
  def initialize questioner
    @questioner = questioner
    @state = :asked
    @addressed_to = nil
  end

  def whose
    @questioner
  end

  def answered?
    @state == :answered || accepted? || rejected?
  end

  def answer by
    check_allowed by 
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

  def rejected?
    @state == :rejected
  end

  def accept by
    check_answered
    check_is_questioner by
    @state = :accepted
  end

  def reject by ,reason
    check_answered
    check_is_questioner by
    @state = :rejected
  end
  
  private 

  def check_answered
    raise UNANSWERED unless answered?
  end

  def check_is_questioner person
    raise NOT_QUESTIONER unless questioner? person
  end

  def check_allowed person
    raise NOT_ALLOWED unless allowed_to_answer? person 
  end
  
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
