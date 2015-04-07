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

  describe 'when answered' do
    let(:answered) {question.answer :anyone
                            question}
    
    it "can be accepted by the questioner" do
      answered.accept :questioner
      expect(question.accepted?).to eq true
    end

    it "must be accepted by the questioner" do
      expect{answered.accept :anybody}.to raise_error 'must be accepted by the questioner'
    end

  end
end