require_relative './mathable'

class TeamStats
  include Mathable
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def team_info(team_id)
    team = @teams_collection.teams.find do |team|
      team_id == team.team_id
    end
    hash = {
      "team_id" => team.team_id,
      "franchise_id" => team.franchiseid,
      "team_name" => team.teamname,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end

  def all_game_teams_for_team(team_id)
    @game_teams_collection.game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
  end

  def game_id_for_team_wins(team_id)
  league_teams = all_game_teams_for_team(team_id).find_all do |game_team|
    game_team.result == "WIN"
  end
  league_teams.map do |game_team|
    game_team.game_id
  end
end

  def best_season(team_id)
    wins = []
    game_id_for_team_wins(team_id).each do |game_id|
      @games_collection.games.each do |game|
        if game.game_id == game_id
          wins << game.season
        end
      end
    end
    season_wins = wins.group_by {|season| season}
    best_season_for_team_id = season_wins.transform_values do |value|
      value.count
    end.invert.max
    [best_season_for_team_id].to_h.values.reduce
  end

  def worst_season(team_id)
    wins = []
    game_id_for_team_wins(team_id).each do |game_id|
      @games_collection.games.each do |game|
        if game.game_id == game_id
          wins << game.season
        end
      end
    end
    season_wins = wins.group_by {|season| season}
    worst_season_for_team_id = season_wins.transform_values do |value|
      value.count
    end.invert.min
    [worst_season_for_team_id].to_h.values.reduce
  end

  def average_win_percentage(team_id)
    wins = 0
    team_id_games = all_game_teams_for_team(team_id)
    total = team_id_games.count
    team_id_games.each do |game_team|
      if game_team.result == "WIN"
        wins +=1
      end
    end
    average(wins.to_f, total)
  end
end
