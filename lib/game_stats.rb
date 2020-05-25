class GameStats
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
    (home_wins.to_f / @games_collection.games.count * 100).round(3)
  end

  def percentage_visitor_wins
    visitor_wins = @games_collection.games.count do |game|
      game.home_goals < game.away_goals
    end
    (visitor_wins.to_f / @games_collection.games.count * 100).round(3)
  end
end
