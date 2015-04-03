class Consensus
  def initialize proposal
    check_proposal proposal
    @circle = Circle.new
    @circle.involve proposal.whose
  end

  def status
    'Introduction'
  end

  def participants
    @circle
  end

  private
  def check_proposal subject
    raise "needs a proposal" unless subject.is_a? Proposal
  end
end