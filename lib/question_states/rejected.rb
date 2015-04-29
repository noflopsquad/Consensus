class Rejected<QuestionState

  def answer
    Answered.new
  end

  def accept
    Accepted.new
  end
    
  def answered?
    true
  end

  def rejected?
    true
  end
end