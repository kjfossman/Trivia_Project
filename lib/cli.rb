require 'pry'

class CLI
    attr_accessor :board, :play_board
    
    def initialize
        @board = Array.new(12, " ")
        binding.pry
    end

    def greeting
        puts "Hello are there one or two players playing today?"
        play_board
    end

    def play_board
        puts "      #{@board[0]}      |      #{@board[0]}      |      #{@board[0]}   "
        puts ""
        puts "      #{@board[0]}      |      #{@board[0]}      |      #{@board[0]}   "
        puts ""
        puts "      #{@board[0]}      |      #{@board[0]}      |      #{@board[0]}   "
        puts ""
        puts "      #{@board[0]}      |      #{@board[0]}      |      #{@board[0]}   "
    end
end