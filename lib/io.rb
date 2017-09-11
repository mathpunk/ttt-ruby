# Note the duplication of `query`. I got surprising messages about initializing with the wrong number of arguments in main.rb when I tried a superclass with that method.

# class IO
#   def query(message)
#     say(message)
#     ask
#   end
# end

class ConsoleIO # < IO

  def say(message)
    puts message
  end

  def ask
    response = gets.chomp
    response
  end

  def query(message)
    say(message)
    ask
  end
end

class InsufficientTestAnswersError < StandardError
end

class MockIO # < IO
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

  def query(message)
    say(message)
    ask
  end
end
