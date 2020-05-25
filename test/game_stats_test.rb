require './test/helper_test'
require './lib/game'
require './lib/game_collection'
require './lib/game_stats'
require 'pry'

class GameStatsTest < Minitest::Test
  def setup
    @games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_stats = GameStats.new(@games_collection)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @game_stats.games_collection
  end

  def test_it_has_total_score
    assert_instance_of Array , @game_stats.total_score
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 8, @game_stats.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 50.00, @game_stats.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 33.75, @game_stats.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 16.25, @game_stats.percentage_ties
  end
end
