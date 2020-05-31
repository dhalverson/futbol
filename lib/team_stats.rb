class TeamStats
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
      :team_id => team.team_id,
      :franchiseid => team.franchiseid,
      :teamname => team.teamname,
      :abbreviation => team.abbreviation,
      :link => team.link
    }
  end

  def all_games(team_id)
    @games_collection.games.find_all do |game|
      (game.away_team_id || game.home_team_id) == team_id
    end
  end

  def all_games_by_team_per_season(team_id)
  end

  def best_season(team_id)
  end
end
