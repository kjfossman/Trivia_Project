require 'pry'
require 'awesome_print'


class CLI
    attr_accessor :board
    attr_reader :play_board
    
    def initialize
        @board = Array.new(12, " ")
        greeting
    end

    def greeting
        puts "Hello are there one or two trivia players today?"
        puts "Enter one or two"
        # input = gets
        play_category_game
        # random_game
        # play_board_random
    end

    def play_category_game
        display_categories
        ask_for_input_category
        play_board_category
        # until @board
        choose_clue
    end

    def valid_choice?(index)
        binding.pry
        index.between?(0, @board.count) && !@board[index].is_a?(String)
    end
    
    def choose_clue
        puts "Select from available clues"
        input = input_to_index(gets)
        until valid_choice?(input) do 
            puts "Not a valid choice, please select again"
            input = input_to_int(gets)
        end
        puts "Question: #{@board[input].question}"
        gets
        puts "Answer: #{@board[input].answer}"
        gets   
    end

    def display_categories
        @board = Category.display_categories
    end

    def ask_for_input_category
        puts "Select the category number that you would like to play"
        input = input_to_int(gets)
        until input.between?(1, Category.all.count) do 
            puts "Not a valid choice, please select again"
            input = input_to_int(gets)
        end
        input = input_to_index(input)
        choose_category(input)
    end

    def play_board_category
        display = []
        @board.each.with_index(1) do |x, index|
            display << "#{index}: $#{x.value}"
        end

        puts @board[0].category.title.upcase
        puts display
    end

    def play_board_random
        display = []
        @board.each.with_index(1) do |x, index|
            display << "#{index}: #{x.category.title} $#{x.value}"
            display << ""
        end 
        puts display
    end

    def choose_category(input)
        @board = @board[input]
            @board = @board.clues.collect do |x|
                x.id
            end
            @board = Clue.all.select do |x|
                @board.include?(x.id)
            end
    end
 
    def random_game
        random_clues
        play_board_random
    end


    def random_clues
        @board = Clue.all.sample(12)
    end

    def board_full
        @board.none?(" ")
    end

    def input_to_index(input)
        input = input.to_i - 1
        return input
    end

    def input_to_int(input)
        input = input.to_i
        return input
    end

end



        # # ap       "(1)#{@board[0].category.title}  $(#{@board[0].value})     |      (2)#{@board[1].category.title}  $(#{@board[1].value})     |      (3)#{@board[2].category.title}  $(#{@board[2].value})  "
        # puts ""
        # puts "      (4)#{@board[3].category.title}  $(#{@board[3].value})     |      (5)#{@board[4].category.title}  $(#{@board[4].value})     |      (6)#{@board[5].category.title}  $(#{@board[5].value})  "
        # puts ""
        # puts "      (7)#{@board[6].category.title}  $(#{@board[6].value})     |      (8)#{@board[7].category.title}  $(#{@board[7].value})     |      (9)#{@board[8].category.title}  $(#{@board[8].value})  "
        # puts ""
        # puts "      (10)#{@board[9].category.title}  $(#{@board[9].value})     |      (11)#{@board[10].category.title}  $(#{@board[10].value})     |      (12)#{@board[11].category.title}  $(#{@board[11].value})  "


                # id = []
        #     12.times do 
        #         id << Clue.all.sample.id
        #     end
        # if id.uniq == id
        #     object = Clue.all.select do |x| 
        #     id.include?(x.id)
        #     end 
        # else 
        #     random_clues
        # end
        # @board = object