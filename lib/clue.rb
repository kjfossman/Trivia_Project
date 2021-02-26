class Clue
    @@all = []

    attr_accessor :value, :category
    attr_reader :answer, :question, :id
    
    def initialize(trivia_hash)
        @id = trivia_hash['id']
        self.value = trivia_hash['value']
        @question = trivia_hash['question']
        @answer = trivia_hash['answer']
        @airdate = trivia_hash['airdate']
        @@all << self
        find_or_create_category(trivia_hash['category']['title'])
        add_clue_to_category
    end

    def value=(value)
        if value == nil 
            @value = 200
        else 
            @value = value
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

    def add_clue_to_category
        category.add_clue(self)
    end

    def self.all
        @@all
    end

end

    # def destroy(question)
    #     if question == ""
    #         @@all.delete(self)
    #     end
    # end

            # if !@@all.include?(self)
        #     return true
        # end

                # if !@@all.include?(self)
        #     return true
        # end

     # trivia_hash.each do |key, value| 
        # self.class.attr_accessor(key)           
        # self.send("#{key}=", value)    