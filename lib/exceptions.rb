class NotAllowed < Exception
  def initialize
    super "The question is addressed to another person"
  end
end

class NotQuestioner < Exception
  def initialize
    super 'this action must be made by the questioner'
  end
end

class Unanswered < Exception
  def initialize
    super 'must be answered before'
  end
end