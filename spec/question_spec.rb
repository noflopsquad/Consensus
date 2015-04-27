describe 'A Question' do

  before do
    @question = Question.new(:questioner)
  end

  it 'starts unanswered' do
    expect(@question.answered?).to eq false
  end

  it 'can be answered' do
    @question.answer :any_person
    expect(@question.answered?).to eq true
  end

  it "can be addressed" do
    @question.address :person
    expect(@question.whom).to eq :person
  end


  describe 'when addressed' do
    it "only could be answered by the addressed person" do
      @question.address :person
      expect{@question.answer(:other_than_addressed)}.to raise_error 'The question is addressed to another person'
    end
  end

  it "must be answered to be accepted " do
      expect{@question.accept :questioner}.to raise_error 'must be answered before' 
  end

  it "must be answered to be rejected " do
      expect{@question.reject :questioner, :any_reason}.to raise_error 'must be answered before' 
  end

  describe 'when answered' do

    before do
      @question.answer :anyone
    end
    
    it "can be accepted by the questioner" do
      @question.accept :questioner
      expect(@question.accepted?).to eq true
    end

    it "must be accepted by the questioner" do
      expect{@question.accept :anybody}.to raise_error 'this action must be made by the questioner'
    end

    it "can be rejected with a reason" do
      @question.reject :questioner,:any_reason
      expect(@question.rejected?).to eq true  
    end

    it "must be rejected by the questioner" do
      expect{@question.reject :anybody, :any_reason}.to raise_error 'this action must be made by the questioner'
    end

  end

  describe 'when rejected' do
    before do
      @question.answer :anyone
      @question.reject :questioner,:any_reason
    end

    it "can be answered again" do
      @question.answer :anybody
      expect(@question.answered?).to eq true
    end

    it "can be accepted" do
      @question.accept :questioner
      expect(@question.accepted?).to eq true
    end

  end
end