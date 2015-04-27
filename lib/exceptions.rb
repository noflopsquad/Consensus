class NotAllowed < Exception
  def initialize
    super "The question is addressed to another person"
  end
end

class NotQuestioner < Exception
  def initialize
    super 'This action must be made by the questioner'
  end
end

class Unanswered < Exception
  def initialize
    super 'Must be answered before'
  end
end

class NotProposal < Exception
  def initialize
    super 'Needs a proposal'
  end
end

class MinimumDurationNotReached < Exception
  def initialize
    super 'Minimum duration not reached yet'
  end
end

class UnacceptedQuestions < Exception
  def initialize
    super 'There are unaccepted questions'
  end
end
