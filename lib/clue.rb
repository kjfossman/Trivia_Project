class Clue
    @@all = []

    attr_accessor :id, :value, :question, :answer, :category, :airdate

    def initialize(trivia_hash, category)
        @id = trivia_hash['id']
        @value = trivia_hash['value']
        @question = trivia_hash['question']
        @answer = trivia_hash['answer']
        @airdate = trivia_hash['airdate']
        @category = category
        # trivia_hash.each do |key, value| 
        # self.class.attr_accessor(key)           
        # self.send("#{key}=", value)
        @@all << self
        # binding.pry
        find_or_create_category(category)
    end

    def create_category(category)  
        # binding.pry
        self.category = Category.new(category)
    end

    def find_category_by_title(category)
        Category.all.find do |x|
            x.title == category
        end
    end

    def find_or_create_category(category)
        if find_category_by_title(category)
        else
            create_category(category)
        end
    end


    # def category=(category)
    #     @category = category
    #     if category
    #         binding.pry
    #         category.add_clue(self)
    #     end
    # end

    def self.all
        @@all
    end

    # def find_category
    #     binding.pry
    #     Category.all.find do |x|
    #         binding.pry
    #         x.title == self.category['title']
    #     end
    # end




end