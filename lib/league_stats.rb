require_relative './game'
require_relative './team'
require_relative './game_team'

class LeagueStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def count_of_teams
    @teams_collection.teams.count
  end

  def unique_team_ids
    ids = @game_teams_collection.game_teams.each do |game_team|
      game_team.team_id
    end
    ids.map do |game_team|
      game_team.team_id.to_i
    end.uniq
  end

  def games_sorted_by_team_id(team_id)
    @game_teams_collection.game_teams.find_all do |game_team|
      game_team.team_id.to_i == team_id
    end
  end

  def total_goals_by_team_id(team_id)
    games_sorted_by_team_id(team_id).sum do |game_team|
      game_team.goals.to_i
    end
  end

  def average_goals_by_team_id(team_id)
      (total_goals_by_team_id(team_id).to_f / games_sorted_by_team_id(team_id).count).round(2)
  end

  def best_offense
    top_o = unique_team_ids.max_by do |team_id|
      average_goals_by_team_id(team_id)
    end
    @teams_collection.teams.find do |team|
      team.team_id == top_o.to_s
    end.teamname
  end

  def worst_offense
    bad_o = unique_team_ids.min_by do |team_id|
      average_goals_by_team_id(team_id)
    end
    @teams_collection.teams.find do |team|
      team.team_id == bad_o.to_s
    end.teamname
  end
end