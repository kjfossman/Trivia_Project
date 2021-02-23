class Category
    @@all = []
    attr_accessor :title

    def initialize(title)
        @title = title
        @clues = []
        @@all << self
    end

    def add_clues
        
    end

    def self.all
        @@all
    end

end