require './lib/circle'

class Consensus
  def initialize proposal
    check_proposal proposal
    @circle = Circle.new
    @circle.involve proposal.whose
  end

  def status
    'Introduction'
  end

  def is_involved? person
    @circle.involved? person
  end

  private

  def check_proposal subject
    raise "needs a proposal" unless subject.is_a? Proposal
  end
end