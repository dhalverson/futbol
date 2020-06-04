class SeasonStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(collections)
    @games_collection = collections[:games_collection]
    @teams_collection = collections[:teams_collection]
    @game_teams_collection = collections[:game_teams_collection]
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

  def games_by_year(season)
    year = season[0..3]
    season_games = @game_teams_collection.game_teams.select do |game|
      game.game_id.start_with?(year)
    end
  end

  def coach_games(season)
    games_by_year(season).group_by do |game|
      game.head_coach
    end
  end

  def wins_to_games(season)
    wins_to_games  = Hash.new(0)
    coach_games(season).each do |coach, games|
      wins = games.find_all do |game|
        game.result == "WIN"
      end
    wins_to_games[coach] = wins.count / games.count.to_f
    end
    wins_to_games
  end

  def winningest_coach(season)
  winning = wins_to_games(season).max_by do |coach, ratio|
    ratio
  end
  winning[0]
  end

  def worst_coach(season)
    losing = wins_to_games(season).min_by do |coach, ratio|
      ratio
    end
    losing[0]
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
    by_teams = games_by_year(season).group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.max}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end

  def fewest_tackles(season)
    by_teams = games_by_year(season).group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.min}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end
end
