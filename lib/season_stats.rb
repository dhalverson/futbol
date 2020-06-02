class SeasonStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def games_by_season(season)
    @games_collection.games.find_all do |game|
      game.season == season
    end
  end

  def game_ids_by_season(season)
    games_by_season(season).map do |game|
      game.game_id
    end
  end

  def game_teams_by_season(season)
    game_teams = []
    @game_teams_collection.game_teams.each do |game_team|
      if game_ids_by_season(season).include?(game_team.game_id)
        game_teams << game_team
      end
    end
    game_teams
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

  def accuracy_by_game_team(season)
  accuracy_by_team = Hash.new(0)
  game_teams_by_season(season).each do |game_team|
    accuracy = (game_team.goals.to_f / game_team.shots.to_f).round(2)
    accuracy_by_team[game_team] = accuracy
  end
  accuracy_by_team
end

  def most_accurate_team(season)
    most_accurate = accuracy_by_game_team(season).max_by do |game_team, accuracy|
      accuracy
    end.first.team_id
    @teams_collection.teams.find do |team|
      team.team_id == most_accurate
    end.teamname
  end

  def least_accurate_team(season)
    least_accurate = accuracy_by_game_team(season).min_by do |game_team, accuracy|
      accuracy
    end.first.team_id
    @teams_collection.teams.find do |team|
      team.team_id == least_accurate
    end.teamname
  end

  def most_tackles(season)
    year = season[0..3]
    season_games = @game_teams_collection.game_teams.select do |game|
      game.game_id.start_with?(year)
    end
    by_teams = season_games.group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.max}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end

  def fewest_tackles(season)
    year = season[0..3]
    season_games = @game_teams_collection.game_teams.select do |game|
      game.game_id.start_with?(year)
    end
    by_teams = season_games.group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.min}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end
end
