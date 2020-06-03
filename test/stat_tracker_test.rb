require './test/helper_test'
require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/game_stats'
require './lib/league_stats'
require './lib/season_stats'
require './lib/team_stats'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
      }

    @stat_tracker = StatTracker.from_csv(@locations)
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

  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.league_stats.count_of_teams
  end

  def test_it_has_highest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.league_stats.highest_scoring_visitor
  end

  def test_it_has_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.league_stats.highest_scoring_home_team
  end

  def test_it_can_find_best_offense
    assert_equal "Reign FC", @stat_tracker.league_stats.best_offense
  end

  def test_it_can_find_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.league_stats.worst_offense
  end

  def test_it_has_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.league_stats.highest_scoring_visitor
  end

  def test_it_has_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.league_stats.highest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.league_stats.lowest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.league_stats.lowest_scoring_home_team
  end

  def test_it_can_find_winningest_coach
    assert_equal "Dan Lacroix", @stat_tracker.season_stats.winningest_coach("20122013")
    assert_equal "Claude Julien", @stat_tracker.season_stats.winningest_coach("20132014")
    assert_equal "Claude Julien", @stat_tracker.season_stats.winningest_coach("20142015")
  end

  def test_it_can_find_worst_coach
    assert_equal "Martin Raymond", @stat_tracker.season_stats.worst_coach("20122013")
    assert_equal "Peter Laviolette", @stat_tracker.season_stats.worst_coach("20132014")
    assert_equal "Peter Laviolette", @stat_tracker.season_stats.worst_coach("20142015")
  end

  def test_it_can_find_most_accurate_team
    assert_equal "Washington Spirit FC", @stat_tracker.season_stats.most_accurate_team("20122013")
    assert_equal "Orlando City SC", @stat_tracker.season_stats.most_accurate_team("20132014")
    assert_equal "LA Galaxy", @stat_tracker.season_stats.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.season_stats.least_accurate_team("20122013")
    assert_equal "Philadelphia Union", @stat_tracker.season_stats.least_accurate_team("20132014")
    assert_equal "DC United", @stat_tracker.season_stats.least_accurate_team("20142015")
  end

  def test_it_can_find_team_with_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.season_stats.most_tackles("20122013")
    assert_equal "FC Cincinnati", @stat_tracker.season_stats.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.season_stats.most_tackles("20142015")
  end

  def test_it_can_find_team_with_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.season_stats.fewest_tackles("20122013")
    assert_equal "Atlanta United", @stat_tracker.season_stats.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.season_stats.fewest_tackles("20142015")
  end

  def test_it_can_find_find_team_info
    expected = {"team_id"=>"1", "franchise_id"=>"23", "team_name"=>"Atlanta United", "abbreviation"=>"ATL", "link"=>"/api/v1/teams/1"}
    expected2 = {"team_id"=>"2", "franchise_id"=>"22", "team_name"=>"Seattle Sounders FC", "abbreviation"=>"SEA", "link"=>"/api/v1/teams/2"}
    assert_equal expected, @stat_tracker.team_stats.team_info("1")
    assert_equal expected2, @stat_tracker.team_stats.team_info("2")
  end

  def test_it_can_find_best_season_for_team_id
    assert_equal "20172018", @stat_tracker.team_stats.best_season("1")
    assert_equal "20142015", @stat_tracker.team_stats.best_season("2")
  end

  def test_it_can_find_worst_season_for_team_id
    assert_equal "20122013", @stat_tracker.team_stats.worst_season("1")
    assert_equal "20122013", @stat_tracker.team_stats.worst_season("2")
  end

  def test_it_can_find_average_win_percentage_for_team_id
    assert_equal 0.36, @stat_tracker.team_stats.average_win_percentage("1")
    assert_equal 0.36, @stat_tracker.team_stats.average_win_percentage("2")
  end
end
