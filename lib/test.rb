
class API

    def initialize
        @url = "http://jservice.io/api/clues"
    end

    def get_data
        response = HTTParty.get(@url)
        binding.pry
    end
end