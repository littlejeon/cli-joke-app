require 'pry'
require 'json'
require 'open-uri'
require 'rest-client'
require 'nokogiri'

class GetJokes

  attr_accessor :url, :joke_data

 

  def initialize
    # if url
    #   @url = url
    # end
    # @joke_data = JSON.load(open(url))
    @chuck_norris_array = []
    @yo_momma_array = []
    @pun_jokes =[]
  end


  # def get_jokes
  #   uri = URI.parse(URL)
  #   response = Net::HTTP.get_response(uri)
  #   response.body
  # end
  

  def chuck_norris_jokes
    #puts "hello"
    #jokes = []
    joke_data = JSON.load(open("http://api.icndb.com/jokes/json")) 
    joke_data["value"].each do |x|
      x.each do |key, value|
        if key == "joke"
          @chuck_norris_array << value.gsub('&quot;', '')
        end
      end
    end
    #binding.pry
  end

  def yo_momma_jokes
    file = File.read("include/yo_momma_jokes.txt").split("\n")
    @yo_momma_array = file
    # binding.pry
  end

  def pun_jokes
     html = RestClient.get('http://bestpunsever.com/node?page=1')
     pun_jokes = Nokogiri::HTML(html)
     pun_jokes.css(".content").css("p").each do |pun|
       @pun_jokes << pun.text
     end
     #binding.pry
  end
  
  def run
    question = 
    <<-QUESTION

    What kind of joke do you want?
      1. Chuck Norris
      2. Yo Momma
      3. A Punny Joke
      4. I hate laughing and want to quit.

    QUESTION
    puts question

    answer = gets.chomp

      if answer == "Chuck Norris" || answer == "1"
        #binding.pry
        puts
        puts @chuck_norris_array.sample
        puts
        sleep 2
        more
      elsif answer == "Yo Momma" || answer == "2"
        puts
        puts @yo_momma_array.sample
        puts
        sleep 2
        more
      elsif answer == "A Punny Joke" || answer == "3"
        puts
        puts @pun_jokes.sample
        puts
        sleep 2
        more
      elsif answer == "I hate laughing and want to quit." || answer == "4"
        puts
        puts "goodbye"
        puts
      else
        puts
        puts "Not a valid answer fool."
        puts
        sleep 2
        run
      end
    end

  def more
    puts "Would you like another joke? 'y' or 'n'"
    answer = gets.chomp
    if answer == "y"
      run
    else answer == "n"
      puts
      puts "goodbye"
      puts
    end
  end


end


jokes = GetJokes.new
jokes.chuck_norris_jokes
jokes.yo_momma_jokes
jokes.pun_jokes
jokes.run
# binding.pry
#jokes.more
#chuck_norris_jokes = GetJokes.new("http://api.icndb.com/jokes/json")
 
