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

  def all_game_teams_for_team(team_id)
    @game_teams_collection.game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
  end

  def game_id_for_team_wins(team_id, win_result)
  league_teams = all_game_teams_for_team(team_id).find_all do |game_team|
    game_team.result == win_result
  end
  league_teams.map do |game_team|
    game_team.game_id
  end
end

  # def best_season(team_id)
  #
  # end
  #
  # def worst_season(team_id)
  #
  # end

  def average_win_percentage(team_id)
    wins = 0
    team_id_games = all_game_teams_for_team(team_id)
    total = team_id_games.count
    team_id_games.each do |game|
      if game.result == "WIN"
        wins +=1
      end
    end
    (wins / total.to_f).round(2)
  end
end
