require_relative "interface"
require_relative "io"

interface = Interface.new(:interactive, ConsoleIO.new)
interface.run_game
