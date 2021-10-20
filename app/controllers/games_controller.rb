require "open-uri"

class GamesController < ApplicationController

  def new
   @letters = 10.times.map { ("A".."Z").to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english = english_word?(@word)
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = URI.open(url).read
    data = JSON.parse(json)
    return json["found"]
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end


end
