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

  it "address clarifying questions to the proposer" do
    consensus.address(clarifying_question)
    expect(clarifying_question.whom).to eq :proposer
  end
end

describe 'A Question' do
  let(:question) { Question.new(:questioner) }
  
  it 'starts unanswered' do
    expect(question.replied?).to eq false
  end

  it 'can be reply' do
    question.reply :any_person
    expect(question.replied?).to eq true
  end

  it "can be addressed" do
    question.address :person
    expect(question.whom).to eq :person
  end

  it "only could be replied by the addressed person if addressed" do
    question.address :person
    expect{question.reply(:other_than_addressed)}.to raise_error 'The question is addressed to another person'
  end

end