require './lib/commons/circle'
require './lib/commons/questionnaire'
require './lib/commons/phase'


class Consensus

  def initialize proposal
    start_introduction_phase 
    accept_proposal proposal
    initialize_questions
    involve proposal.whose
  end

  def status
    say_status
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

  def next_phase
    check_ready_to_change
    to_next_phase
  end

  private
  
  def say_status
    @status.to_s
  end

  def start_introduction_phase
    @status = Introduction.new
  end

  def to_next_phase
      @status = @status.next
  end

  def check_ready_to_change
    raise UnacceptedQuestions.new if any_questions?
  end

  def check_proposal subject
    raise NotProposal.new unless subject.is_a? Proposal
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