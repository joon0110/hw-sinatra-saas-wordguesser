class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    unless letter.is_a?(String) && letter.match?(/\A[a-z]\z/i)
      raise ArgumentError, 'Guess must be one letter'
    end
    letter = letter.downcase
    return false if @guesses.include?(letter) ||
                  @wrong_guesses.include?(letter)

    if @word.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    true
  end

  def word_with_guesses
    @word.chars.map { |letter| @guesses.include?(letter) ? letter : '-' }.join
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7

    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
