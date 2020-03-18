class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    @include = included?(@answer.downcase, @letters.downcase)
  end

  def included?(answer, letters)
    grid = letters.chars
    answer.chars.all? { |letter| answer.count(letter) <= grid.count(letter) }
  end
end

# PSU
# Add methods that check the different contitions. Call them in 'score'
# 1. The word can’t be built out of the original grid
# params["word"]
# Att a time and a score for each attempt



# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
