require_relative './mathable'

class GameStats
  include Mathable

  attr_reader :games_collection

  def initialize(games_collection)
    @games_collection = games_collection
  end

  def total_score
    @games_collection.games.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

  def percentage_home_wins
    home_wins = @games_collection.games.count do |game|
      game.home_goals > game.away_goals
    end
    average(home_wins.to_f, @games_collection.games.count)
  end

  def percentage_visitor_wins
    visitor_wins = @games_collection.games.count do |game|
      game.home_goals < game.away_goals
    end
    average(visitor_wins.to_f, @games_collection.games.count)
  end

  def percentage_ties
    ties = @games_collection.games.count do |game|
      game.home_goals == game.away_goals
    end
    average(ties.to_f, @games_collection.games.count)
  end

  def games_by_season
    @games_collection.games.reduce({}) do |acc, game|
      acc[game.season] << game if acc[game.season]
      acc[game.season] = [game] if acc[game.season].nil?
      acc
    end
  end

  def count_of_games_by_season
    hash_count = games_by_season
    games_by_season.each do |season, games|
      hash_count[season] = games.count
    end
    hash_count
  end

  def average_goals_per_game
    game_average = total_score.sum do |score|
      score
    end
    average(game_average.to_f, @games_collection.games.count)
  end

  def average_goals_by_season
    games_by_season.transform_values do |games|
      average = games.sum do |game|
        (game.home_goals + game.away_goals).to_f
      end
      average(average, games.count)
    end
  end
end
