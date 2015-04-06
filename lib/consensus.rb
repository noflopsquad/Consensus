require './lib/circle'
require './lib/questionnaire'

class Consensus

  def initialize proposal
    accept_proposal proposal
    initialize_questions
    involve proposal.whose
  end

  def status
    'Introduction'
  end

  def is_involved? person
    circle.involved? person
  end

  def address question
    involve question.whose
    address_to_proposer question
  end

  def any_questions?
    questions.any_unresolved?
  end
  
  private

  def check_proposal subject
    raise "needs a proposal" unless subject.is_a? Proposal
  end

  def accept_proposal proposal
    check_proposal proposal
    @proposal = proposal    
  end

  def initialize_questions
    @questions = Questionnaire.new
  end

  def involve person
    circle.involve person
  end

  def circle
    @circle = Circle.new if @circle.nil?
    @circle
  end

  def questions
    @questions
  end

  def address_to_proposer question
    @questions.add question
    question.address @proposal.whose
  end 
end