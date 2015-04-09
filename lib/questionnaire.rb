class Questionnaire
  def initialize
    @questions = Array.new
  end

  def add question
    @questions.push question
  end

  def any_unresolved?
    @questions.any? {|question| question.unaccepted?}
  end
end