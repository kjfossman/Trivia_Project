
class API

    def initialize
        @url = "http://jservice.io/api/clues"
    end

    def get_data
        trivia_array = HTTParty.get(@url)
        create_trivia_objects(trivia_array)
      
    end

    def create_trivia_objects(trivia_array)
        trivia_array.each do |trivia_hash|
            Clue.new(trivia_hash)
        end
    end
end