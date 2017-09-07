require_relative "interface"
require_relative "io"

interface = Interface.new(:human_computer, ConsoleIO)
interface.start_game
