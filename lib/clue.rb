class Clue
    @@all = []

    def initialize(trivia_hash)
        trivia_hash.each do |key, value| 
        self.class.attr_accessor(key)           
        self.send("#{key}=", value)
        end
        @@all << self

    end

    def self.all
        @@all
    end

end