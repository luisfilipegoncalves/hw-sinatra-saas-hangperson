class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses

  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess letter
    raise ArgumentError if letter.nil? || letter.empty? || letter !~ /\w/
    lowerCaseLetter = letter.downcase
    if @word.include? lowerCaseLetter
      
      if @guesses.include? lowerCaseLetter
        return false
      else
        @guesses.concat lowerCaseLetter 
        return true
      end
      
    else 
      if @wrong_guesses.include? lowerCaseLetter
        return false
      else
        @wrong_guesses.concat lowerCaseLetter 
        return true
      end
    end
     
  end
  
  def word_with_guesses
    @word.split('').map { |letter| @guesses.include?(letter) ? letter : '-' }.join
  end

  def check_win_or_lose
    puts "word: #{word} guesses: #{@guesses}"
    return :win if @word.downcase.split('').sort == @guesses.downcase.split('').sort 
    @guesses.size + @wrong_guesses.size == 7 ? :lose : :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
