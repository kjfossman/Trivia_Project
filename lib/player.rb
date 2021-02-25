class Player
    @@all = []

    attr_accessor :name, :score
    
    def initialize(name)
        @name = name
        @score = 0
        @@all << self
    end

    def self.all
        @@all
    end

end