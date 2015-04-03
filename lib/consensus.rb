require './lib/circle'
require './lib/questionnaire'

class Consensus
  def initialize proposal
    check_proposal proposal
    @questions = Questionnaire.new
    @circle = Circle.new
    @circle.involve proposal.whose
  end

  def status
    'Introduction'
  end

  def is_involved? person
    @circle.involved? person
  end

  def address question
    @questions.add question
  end

  def any_questions?
    @questions.any_unresolved?
  end
  private

  def check_proposal subject
    raise "needs a proposal" unless subject.is_a? Proposal
  end
end