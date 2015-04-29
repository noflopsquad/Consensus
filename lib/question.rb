require './lib/commons/exceptions'
require './lib/question_states/question_state'
require './lib/question_states/asked'
require './lib/question_states/answered'
require './lib/question_states/accepted'
require './lib/question_states/rejected'

class Question
  
  def initialize questioner
    @questioner = questioner
    @the_state = Asked.new
    @addressed_to = nil
  end

  def whose
    @questioner
  end

  def answered?
    @the_state.answered?
  end

  def answer by
    check_allowed by 
    @the_state = @the_state.answer
  end

  def whom
    @addressed_to
  end

  def address person
    @addressed_to = person
  end

  def accepted?
    @the_state.accepted?
  end

  def unaccepted?
    !@the_state.accepted?
  end

  def rejected?
    @the_state.rejected?
  end

  def accept by
    check_answered
    check_is_questioner by
    @the_state = @the_state.accept
  end

  def reject by ,reason
    check_answered
    check_is_questioner by
    @the_state = @the_state.reject
  end
  
  private 

  def check_answered
    raise Unanswered.new unless answered?
  end

  def check_is_questioner person
    raise NotQuestioner.new unless questioner? person
  end

  def check_allowed person
    raise NotAllowed.new unless allowed_to_answer? person 
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
