require 'pry'

class CLI
    attr_accessor :board, :play_board
    
    def initialize
        @board = Array.new(12, " ")
        test
    end

    def test 
        @board = @board.map do |x|
            x = 'pizza'
        end
        binding.pry
    end

    def greeting
        puts "Hello are there one or two players playing today?"
        board_full
        play_board
    end

    def play_board
        puts "      #{@board[0]}      |      #{@board[1]}      |      #{@board[2]}   "
        puts ""
        puts "      #{@board[3]}      |      #{@board[4]}      |      #{@board[5]}   "
        puts ""
        puts "      #{@board[6]}      |      #{@board[7]}      |      #{@board[8]}   "
        puts ""
        puts "      #{@board[9]}      |      #{@board[10]}      |      #{@board[11]}   "
    end

    def random_clues
        group = []
        Clue.all.each do 
        end
    end

    def board_full
        @board.none?(" ")
    end

end