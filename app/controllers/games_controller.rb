require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @score = params[:word_answer]
    @run_game = run_game(@score)
  end

  def isinclude?(attempt)
    attempt.chars.all? { |x| attempt.count(x) <= params[:letters].count(x) }
  end

  def wordexistence(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_checker = open(url).read
    dictionnary = JSON.parse(word_checker)
    dictionnary['found']
  end

  def run_game(attempt)
    # TODO: runs the game and return detailed hash of result
    if isinclude?(attempt.upcase) && wordexistence(attempt)
      'well done'
    elsif isinclude?(attempt.upcase)
      'not an english word'
    else
      'not in the grid'
    end
  end
end
