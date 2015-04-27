require './lib/proposal'
require './lib/consensus'
require './lib/question'

describe 'A Consensus' do
  
  before do
    @proposal = Proposal.new(:proposer)
    @consensus= Consensus.new(@proposal)
    @clarifying_question = Question.new(:questioner)
  end

  it 'needs a proposal' do
    non_proposal = nil

    expect{Consensus.new(non_proposal)}.to raise_error "needs a proposal"
    expect{Consensus.new(@proposal)}.to_not raise_error
  end

  it 'starts with an introduction' do
    expect(@consensus.status).to eq 'Introduction'
  end

  it 'has the proposer as a participant' do
    expect(@consensus.is_involved? :proposer).to eq true
    expect(@consensus.is_involved? :not_the_proposer).to eq false
  end

  it "accepts question in the introduccion phase" do
    @consensus.address(@clarifying_question)
    expect(@consensus.any_questions?).to eq true
  end

  describe 'when a clarifying question is addressed' do
    before do
      @consensus.address(@clarifying_question)
    end

    it "considers the questioner involved" do
      expect(@consensus.is_involved? :questioner).to eq true
    end

    it "questions are addressed to the proposer" do
      expect(@clarifying_question.whom).to eq :proposer
    end

    it "considers open any unaccepted question" do
      @clarifying_question.answer :proposer
      expect(@consensus.any_questions?).to eq true
    end

    it "considers closed accepted questions" do
      @clarifying_question.answer :proposer
      @clarifying_question.accept :questioner
      expect(@consensus.any_questions?).to eq false
    end

  end

  it "the introduction phase has a minimum duration " do
    minimum_duration_in_days = 2
    expect{@consensus.next_phase}.to raise_error "Minimum duration not reached yet"
    time_passes minimum_duration_in_days + 1
    expect{@consensus.next_phase}.not_to raise_error
  end

  def time_passes days
    new_time = Time.now + (days*24*60*60)
    Time.stub(:now).and_return(Time.new(new_time.to_i))
  end
end
