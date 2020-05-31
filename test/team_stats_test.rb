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

  def test_returns_all_games_by_team_id
    assert_instance_of Array, @team_stats.all_games("1")
  end

  def test_returns_all_games_by_team_per_season
    assert_instance_of Array, @team_stats.all_games("1")
  end

  def test_it_has_best_season
    assert_equal "", @team_stats.best_season("1")
  end
end
