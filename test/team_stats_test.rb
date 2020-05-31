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
end
