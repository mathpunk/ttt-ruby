class ConsoleIO
  def self.say(message)
    puts message
  end

  def self.ask
    response = gets.chomp
    response
  end
end

class TestIO
  def self.say(message)
    message
  end
  def self.ask
    "n"
  end
end
