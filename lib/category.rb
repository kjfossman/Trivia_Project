class Category
    @@all = []
    attr_accessor :title, :clues, :question, :answer, :value

    def initialize(title)
        @title = title
        @clues = []
        @@all << self
    end

    def add_clue(clue)
        @clues << clue
    end

    def self.display_categories
        self.all.each.with_index(1) do |x, index|
            puts "#{index}. #{x.title}"
        end
    end

    def self.find_category(title, id)   
        
        object = self.all.find do |x|
                    x.title == title
                    end
        object.find_question(id)
    end

    def find_question(id)
        q = self.clues.find do |x|
                    x.id == id
                    end
        q
        binding.pry            
    end

    # def display_question(value)



    def self.all
        @@all
    end

end