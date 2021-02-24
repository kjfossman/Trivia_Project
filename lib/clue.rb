class Clue
    @@all = []

    attr_accessor :id, :value, :question, :answer, :category, :airdate

    def initialize(trivia_hash)
        @id = trivia_hash['id']
        # if trivia_hash['value'] == nil
        #     @value = 200
        # else
        self.value = trivia_hash['value']
        # end
        @question = trivia_hash['question']
        @answer = trivia_hash['answer']
        @airdate = trivia_hash['airdate']
        # @category = trivia_hash['category']['title']
        # trivia_hash.each do |key, value| 
        # self.class.attr_accessor(key)           
        # self.send("#{key}=", value)
        @@all << self
        destroy(trivia_hash['question'])
        find_or_create_category(trivia_hash['category']['title'])
        add_clue_to_category(self)
    end

    def value=(value)
        if value == nil 
            @value = 200
        else 
            @value = value
        end
    end

    def destroy(question)
        if question == ""
            @@all.delete(self)
        end
    end

    def create_category(category)  
        self.category = Category.new(category)
    end

    def find_category_by_title(category)
        Category.all.find do |x|
            x.title == category
        end
    end

    def find_or_create_category(category)
        object = find_category_by_title(category)
        if object
            self.category = object
        else
            create_category(category)
        end
    end

    def add_clue_to_category(clue)
        category.add_clue(clue)
    end

    def self.all
        @@all
    end

end