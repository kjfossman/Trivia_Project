class Player
    @@all = []

    attr_accessor :name, :score, :stats, :correct, :incorrect
    
    def initialize(name)
        @name = name
        @score = 0
        @correct = 0
        @incorrect = 0
        @@all << self
    end

    def self.all
        @@all
    end

    def stats
        puts "#{self.correct} Correct Answers"
        puts "#{self.incorrect} Incorrect Answers"
        puts "Total Value $#{self.score}"
    end

end