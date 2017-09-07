class ConsoleIO
  def say(message)
    puts message
  end

  def ask
    response = gets.chomp
    response
  end
end

class TestIO

  attr_reader :messages

  def initialize
    @messages = []
  end
  def say(message)
    @messages.push(message)
  end
  def ask
    "n"
  end
end
