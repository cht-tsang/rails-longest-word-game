require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    def generate_grid
      Array.new(10) { ('A'..'Z').to_a.sample }
    end

    @letters = generate_grid
  end
  
  def score
    
    guess = params[:answer]
    grid = @letters

    def included?(guess, grid)
      guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
    end

    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end

    
    if included?(guess.upcase, grid)
      if english_word?(guess)
        @result = "Congratulations! #{guess} is a valid english word!"
      else
        @result = "Sorry but #{guess} doesn't seem to be an english word..."
      end
    else
      @result = "Sorry but #{guess} can't be built out of #{grid}."
    end
    

  end
end
