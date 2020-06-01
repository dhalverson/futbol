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
      team_id == game.home_team_id || team_id == game.away_team_id
    end
  end

  def all_games_by_team_per_season(team_id)
    all_games(team_id).group_by do |game|
      game.season
    end
  end

  def count_team_wins_per_season(team_id)
    wins = Hash.new(0)
    all_games(team_id).each do |game|
      if team_id == (game.home_team_id && (game.home_goals > game.away_goals))
        wins[game.team_id] += 1.0
      elsif team_id == (game.away_team_id && (game.away_goals > game.home_goals))
        wins[game.team_id] += 1.0
      end
    end
    wins
  end
  end

  def win_percentage_by_season
    all_games_by_team_per_season(team_id).trasnform_values do |season|
      wins = c
  end


# def high_low_key_return(given_hash, high_low)
#   if high_low == :high
#     given_hash.max_by {|k,v| v}[0]
#   elsif high_low == :low
#     given_hash.min_by {|k,v| v}[0]
#   end
# end
#
# end
#
  def best_season(team_id)

  end
end
