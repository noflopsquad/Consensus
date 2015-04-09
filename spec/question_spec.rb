describe 'A Question' do
  let(:question) { Question.new(:questioner) }
  
  it 'starts unanswered' do
    expect(question.answered?).to eq false
  end

  it 'can be reply' do
    question.answer :any_person
    expect(question.answered?).to eq true
  end

  it "can be addressed" do
    question.address :person
    expect(question.whom).to eq :person
  end


  describe 'when addressed' do
    it "only could be answered by the addressed person" do
      question.address :person
      expect{question.answer(:other_than_addressed)}.to raise_error 'The question is addressed to another person'
    end
  end

  it "must be answered to be accepted " do
      expect{question.accept :questioner}.to raise_error 'must be answered before' 
  end

  it "must be answered to be rejected " do
      expect{question.reject :questioner, :any_reason}.to raise_error 'must be answered before' 
  end

  describe 'when answered' do
    let(:answered) {question.answer :anyone
                            question}
    
    it "can be accepted by the questioner" do
      answered.accept :questioner
      expect(question.accepted?).to eq true
    end

    it "must be accepted by the questioner" do
      expect{answered.accept :anybody}.to raise_error 'this action must be made by the questioner'
    end

    it "can be rejected with a reason" do
      answered.reject :questioner,:any_reason
      expect(answered.rejected?).to eq true  
    end

    it "must be rejected by the questioner" do
      expect{answered.reject :anybody, :any_reason}.to raise_error 'this action must be made by the questioner'
    end

  end

  describe 'when rejected' do
    let(:rejected) {question.answer :anyone
                    question.reject :questioner,:any_reason
                    question}
    
    it "can be answered again" do
      rejected.answer :anybody
      expect(rejected.answered?).to eq true
    end

    it "can be accepted" do
      rejected.accept :questioner
      expect(rejected.accepted?).to eq true
    end

  end
end