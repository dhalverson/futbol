require './test/helper_test'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require './lib/team'
require './lib/team_collection'
require './lib/game_team'
require './lib/game_team_collection'
require './lib/team_stats'
require 'pry'

class TeamStatsTest < Minitest::Test
  def setup
    games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    teams_collection = TeamCollection.new("./data/teams.csv")
    game_teams_collection = GameTeamCollection.new("./test/fixtures/game_teams_truncated.csv")

    locations = {
      games_collection: games_collection,
      teams_collection: teams_collection,
      game_teams_collection: game_teams_collection
      }

    @team_stats = TeamStats.new(locations)
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @team_stats.games_collection
    assert_instance_of TeamCollection, @team_stats.teams_collection
    assert_instance_of GameTeamCollection, @team_stats.game_teams_collection
  end

  def test_it_has_team_info
    assert_instance_of Hash, @team_stats.team_info("1")
  end

  def test_returns_all_game_teams_by_team_id
    assert_instance_of Array, @team_stats.all_game_teams_for_team("1")
  end

  def test_it_returns_game_ids_for_team_win_results
    assert_instance_of Array, @team_stats.game_id_for_team_wins("1", "WIN")
    assert_equal ["2012020122", "2012020461", "2015020453"], @team_stats.game_id_for_team_wins("1", "WIN")
  end

  # def test_it_has_best_season_for_team_id
  #   assert_equal "", @team_stats.best_season("1")
  # end

  # def test_it_has_worst_season_for_team_id
  #   assert_equal "", @team_stats.worst_season("1")
  # end
  #
  def test_it_has_average_win_percentage_of_all_games_for_team_id
    assert_equal 0.43, @team_stats.average_win_percentage("1")
    assert_equal 0.40, @team_stats.average_win_percentage("14")
    assert_equal 0.42, @team_stats.average_win_percentage("52")
  end
end
