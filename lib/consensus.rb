require './lib/circle'
require './lib/questionnaire'

class Consensus
  MINIMUM_TIME = 2
  SECONDS_IN_A_DAY = (24*60*60)

  def initialize proposal
    accept_proposal proposal
    initialize_questions
    involve proposal.whose
    calculate_expiration
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

  def next_phase
    check_ready_to_change
  end

  private

  def check_ready_to_change
    raise MinimumDurationNotReached.new unless minimum_time_has_passed?
  end

  def minimum_time_has_passed?
    Time.now.to_i >= @expiration_time
  end

  def calculate_expiration
    @expiration_time = Time.now.to_i + (MINIMUM_TIME * SECONDS_IN_A_DAY)
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