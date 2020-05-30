require './test/helper_test'
require './lib/stat_tracker'
require './lib/game_stats'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/league_stats'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
      }

    @stat_tracker = StatTracker.from_csv(@locations)
    @games_collection = GameCollection.new("./data/games.csv")
    @game_stats = GameStats.new(@games_collection)
    @game_teams_collection = GameTeamCollection.new("./data/game_teams.csv")
    @league_stats = LeagueStats.new(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_highest_total_score
    assert_equal 11, @stat_tracker.game_stats.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 0, @stat_tracker.game_stats.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 0.44, @stat_tracker.game_stats.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.game_stats.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 0.2, @stat_tracker.game_stats.percentage_ties
  end

  def test_it_has_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20132014"=>1323,
      "20142015"=>1319,
      "20152016"=>1321,
      "20162017"=>1317,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.game_stats.count_of_games_by_season
  end

  def test_it_has_average_goals_per_game
    assert_equal 4.22, @stat_tracker.game_stats.average_goals_per_game
  end

  def test_it_has_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20132014"=>4.19,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20162017"=>4.23,
      "20172018"=>4.44
    }
    assert_equal expected, @stat_tracker.game_stats.average_goals_by_season
  end
end
