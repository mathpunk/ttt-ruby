class ConsoleIO
  def say(message)
    puts message
  end

  def ask
    response = gets.chomp
    response
  end
end

class InsufficientTestAnswersError < StandardError
end

class MockIO
  attr_reader :messages, :answers

  def initialize(answers: ["n"])
    @answers = answers
    @messages = []
  end

  def say(message)
    messages.push(message)
  end
  def ask
    answer = answers.shift
    answer ? answer : raise(InsufficientTestAnswersError)
  end
end
