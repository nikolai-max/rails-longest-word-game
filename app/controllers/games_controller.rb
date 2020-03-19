require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @time = Time.now
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    @include = included?(@answer.downcase, @letters.downcase)
    @english_word = english_word?(@answer)
    @score = calculating_score(@answer)
  end

  def included?(answer, letters)
    grid = letters.chars
    answer.chars.all? { |letter| answer.count(letter) <= grid.count(letter) }
  end

  def english_word?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    dictionary_serialized = open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    dictionary["found"]
  end

  def calculating_score(answer)
    @start_time = Time.parse(params["time"])
    @end_time = Time.now
    length = answer.length * answer.length * answer.length
    @total_time = @end_time - @start_time
    score = length - (@total_time)
    score.round * 100
  end
end

# PSU
# Add methods that check the different contitions. Call them in 'score'
# 1. The word can’t be built out of the original grid
# params["word"]
# 2. The word is valid according to the grid, but is not a valid English word
# Att a time and a score for each attempt
# Controll that the word is walid by sending it to the lewagon dictionary API
# If it´s not, give an error message


# The word is valid according to the grid and is an English word
