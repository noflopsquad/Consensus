require './lib/proposal'
require './lib/consensus'
require './lib/question'

describe 'A Consensus' do
  let(:proposal) { Proposal.new(:proposer) }
  let(:consensus) { Consensus.new(proposal) }
  let(:clarifying_question) { Question.new(:questioner) }

  it 'needs a proposal' do
    non_proposal = nil

    expect{Consensus.new(non_proposal)}.to raise_error "needs a proposal"
    expect{consensus}.to_not raise_error
  end

  it 'starts with an introduction' do
    expect(consensus.status).to eq 'Introduction'
  end

  it 'has the proposer as a participant' do
    expect(consensus.is_involved? :proposer).to eq true
    expect(consensus.is_involved? :not_the_proposer).to eq false
  end

  it "accepts question in the introduccion phase" do
    consensus.address(clarifying_question)
    expect(consensus.any_questions?).to eq true
  end

  it "considers the questioner involved" do
    expect(consensus.is_involved? :questioner).to eq false
    consensus.address(clarifying_question)
    expect(consensus.is_involved? :questioner).to eq true
  end

end
