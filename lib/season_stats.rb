class SeasonStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  # def games_by_coach(head_coach)
  #   @game_teams_collection.game_teams.find_all do |game_team|
  #     game_team.head_coach == head_coach
  #   end
  # end
  def games_by_season(season)
    @games_collection.games.find_all do |game|
      game.season == season
    end
  end

  def game_teams_by_season(season)
    acc = []
    @game_teams_collection.game_teams.each do |game_team|
      games_by_season(season).each do |game|
        if game_team.game_id == game.game_id
          acc << game_team
        end
      end
    end
    acc
  end

  def total_games_per_coach(season)
    total = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      total[game_team.head_coach] += 1.0
    end
    total
  end

  def total_wins_per_coach(season)
    wins = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      if game_team.result == "LOSS" || game_team.result == "TIE"
        wins[game_team.head_coach] += 0.0
      elsif game_team.result == "WIN"
        wins[game_team.head_coach] += 1.0
      end
    end
    wins
  end

  def winningest_coach(season)
    wins_to_total_games = Hash.new(0)
    total_games_per_coach(season).each do |coach_total, total_games|
      total_wins_per_coach(season).each do |coach_wins, total_wins|
        if coach_total == coach_wins
          wins_to_total_games[coach_wins] = (total_wins / total_games.to_f)
        end
      end
    end
    winning = wins_to_total_games.max_by do |coach, ratio|
      ratio
    end
    winning[0]
  end

  def worst_coach(season)
    wins_to_total_games = Hash.new(0)
    total_games_per_coach(season).each do |coach_total, total_games|
      total_wins_per_coach(season).each do |coach_wins, total_wins|
        if coach_total == coach_wins
          wins_to_total_games[coach_wins] = (total_wins / total_games.to_f)
        end
      end
    end
    winning = wins_to_total_games.min_by do |coach, ratio|
      ratio
    end
    winning[0]
  end
end
