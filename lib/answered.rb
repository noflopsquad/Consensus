class Answered<QuestionState
  
  def accept
    Accepted.new
  end

  def reject
    Rejected.new
  end
  
  def answered?
    true
  end

end