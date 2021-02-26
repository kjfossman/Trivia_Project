require 'pry'
require 'awesome_print'
 


class CLI
    
    def initialize
        @board = [2, 2]
        greeting
        choose_game
    end

    def greeting
        puts "Hello who are the two trivia players today?...Type Player 1's name to get started!"
        @player_1 = Player.new(gets.chomp)
        puts "Welcome #{@player_1.name} good luck today! Player 2 please enter your name!"
        @player_2 = Player.new(gets.chomp)
        puts "Good luck #{@player_2.name}\n\n" 
        # puts ""
    end

    def choose_game
        puts 'Type category to choose the category you would like to compete in'
        puts 'Type random to play a game with randomly generated clues'
        puts 'Type anything else to quit'
        input = gets.chomp
        case input
            when 'category' then play_category_game
            when 'random' then play_random_game
            else return 'quit' 
        end
        sleep(2)
        puts ""
        ap "#{@player_1.name}"
        @player_1.stats
        ap "#{@player_2.name}"
        @player_2.stats
    end        

    def play_category_game
        display_categories
        ask_for_input_category
        until board_empty(@board) do 
            play_board_category
            choose_clue
        end
        winner_loser
    end

    def play_random_game
        puts "How many clues would you like to have? type a number between 2-20"
        input = input_to_int(gets)
        until input.between?(2, 20)
            puts "Not a valid choice, please select again"
            input = input_to_int(gets)
        end
        random_clues(input)
        until board_empty(@board) do
            play_board_random
            choose_clue
        end
        winner_loser
    end
    
    def winner_loser
        if @player_1.score > @player_2.score 
               ap "#{@player_1.name} WINS with $#{@player_1.score}!"
               puts "#{@player_2.name} Loses with $#{@player_2.score}!"
        elsif @player_2.score > @player_1.score
               ap "#{@player_2.name} WINS with $#{@player_2.score}!"
               puts "#{@player_1.name} LOSES with $#{@player_1.score}!" 
        else
               puts "#{@player_2.name} and #{@player_1.name} tie with $#{@player_2.score}!"
        end
    end

    def log_result(input, result)
        if result == 1 
            current_player.correct += 1
            current_player.score += @board[input].value
            @board[input] = "CORRECT (#{current_player.name} + $#{@board[input].value})"
        else
            current_player.incorrect += 1
            current_player.score -= @board[input].value
            @board[input] = "INCORRECT (#{current_player.name} - $#{@board[input].value})"
        end
    end

    def valid_choice?(index)
        index.between?(0, @board.count - 1) && !@board[index].is_a?(String)
    end
    
    def choose_clue
        input = input_to_index(gets)
        until valid_choice?(input) do 
            puts "Not a valid choice, please select again"
            input = input_to_index(gets)
        end
        puts "Category: #{@board[input].category.title.upcase}"
        puts "Question: #{@board[input].question}"
        puts "Type your answer here:"
        gets 
        sleep(1)
        puts "Answer: #{@board[input].answer}"
        puts "You are the judge was that correct 1 = Yes 2 = No"
        result = input_to_int(gets)
        until result == 1 || result == 2
            puts "Invalid result, please type 1 or 2"
            result = input_to_int(gets)
        end
        log_result(input, result)
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
            if !x.is_a?(String) 
            display << "#{index}: $#{x.value}"
            else 
                display << "#{index}: #{x}"
            end
        end
        ap "#{@category_display} - #{current_player.name} please choose a clue"
        puts display
    end

    def play_board_random
        display = []
        @board.each.with_index(1) do |x, index|
            if !x.is_a?(String) 
                display << "#{index}: #{x.category.title} $#{x.value}"
            else 
                display << "#{index}: #{x}"
            end
        end 
        ap "#{current_player.name.upcase} PLEASE CHOOSE ONE FROM THE FOLLOWING"
        puts display
    end

    def choose_category(input)
        # binding.pry
        @board = @board[input]
            @board = @board.clues.collect do |x|
                x.id
            end
            @board = Clue.all.select do |x|
                @board.include?(x.id)
            end
        @category_display = @board[0].category.title.upcase    
    end
 
    def random_clues(int)
        @board = Clue.all.sample(int)
    end

    def board_empty(board)
        board.all?(String)
    end

    def input_to_index(input)
        input = input.to_i - 1
        return input
    end

    def input_to_int(input)
        input = input.to_i
        return input
    end

    def turn_count
        @board.count - @board.select.count {|x| x.is_a?(String)}
    end

    def current_player
        turn_count % 2 == 0 ? @player_2 : @player_1
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