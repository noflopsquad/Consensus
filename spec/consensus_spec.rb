describe 'A Consensus' do
  let(:proposal) { Proposal.new(:proposer) }
  let(:consensus) { Consensus.new(proposal) }

  it 'needs a proposal' do
    non_proposal = nil

    expect{Consensus.new(non_proposal)}.to raise_error "needs a proposal"
    expect{consensus}.to_not raise_error
  end

  it 'starts with an introduction' do
    expect(consensus.status).to eq 'Introduction'
  end

  it 'has a circle' do
    expect(consensus.participants).to be_a Circle
  end

  it 'has the proposer as a participant' do
    the_circle = consensus.participants

    expect(the_circle.involved? :proposer).to eq true
    expect(the_circle.involved? :not_the_proposer).to eq false
  end
end

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

class Proposal
  def initialize proposer
    @proposer = proposer
  end

  def whose
    @proposer
  end
end

class Circle
  def initialize
    @members = Array.new
  end

  def involve who
    @members.push who
  end

  def involved? who
    @members.include? who
  end
end
