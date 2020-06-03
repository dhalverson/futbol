require './test/helper_test'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require './lib/team'
require './lib/team_collection'
require './lib/game_team'
require './lib/game_team_collection'
require './lib/season_stats'
require 'pry'

class SeasonStatsTest < Minitest::Test
  def setup
    games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    teams_collection = TeamCollection.new("./data/teams.csv")
    game_teams_collection = GameTeamCollection.new("./test/fixtures/game_teams_truncated.csv")

    collections = {
      games_collection: games_collection,
      teams_collection: teams_collection,
      game_teams_collection: game_teams_collection
      }

    @season_stats = SeasonStats.new(collections)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @season_stats.games_collection
    assert_instance_of TeamCollection, @season_stats.teams_collection
    assert_instance_of GameTeamCollection, @season_stats.game_teams_collection
  end

  def test_it_can_get_games_by_season
    assert_equal 40, @season_stats.games_by_season("20122013").count
  end

  def test_game_ids_by_season
    assert_instance_of Array, @season_stats.game_ids_by_season("20122013")
    assert_equal 40, @season_stats.game_ids_by_season("20122013").count
    assert_equal 40, @season_stats.game_ids_by_season("20132014").count
    assert_equal 40, @season_stats.game_ids_by_season("20142015").count
    assert_equal 40, @season_stats.game_ids_by_season("20152016").count
    assert_equal 40, @season_stats.game_ids_by_season("20162017").count
    assert_equal 40, @season_stats.game_ids_by_season("20172018").count
  end

  def test_game_teams_by_season
    assert_instance_of Array, @season_stats.game_teams_by_season("20122013")
    assert_equal 40, @season_stats.game_teams_by_season("20122013").count
    assert_equal 40, @season_stats.game_teams_by_season("20132014").count
    assert_equal 40, @season_stats.game_teams_by_season("20142015").count
    assert_equal 40, @season_stats.game_teams_by_season("20152016").count
    assert_equal 40, @season_stats.game_teams_by_season("20162017").count
    assert_equal 40, @season_stats.game_teams_by_season("20172018").count
  end

  def test_it_can_get_games_by_year
    assert_instance_of Array, @season_stats.games_by_year("20132014")
    assert_instance_of GameTeam, @season_stats.games_by_year("20132014")[0]
    assert_equal 40, @season_stats.games_by_year("20132014").count
  end

  def test_it_can_get_coach_games_by_season
    assert_instance_of Hash, @season_stats.coach_games("20132014")
    assert_equal 20, @season_stats.coach_games("20132014").count
  end

  def test_it_can_get_winningest_coach
    assert_equal "Lindy Ruff", @season_stats.winningest_coach("20122013")
    assert_equal "Claude Noel", @season_stats.winningest_coach("20132014")
    assert_equal "Paul Maurice", @season_stats.winningest_coach("20142015")
    assert_equal "Bill Peters", @season_stats.winningest_coach("20152016")
    assert_equal "Joel Quenneville", @season_stats.winningest_coach("20162017")
    assert_equal "Rick Tocchet", @season_stats.winningest_coach("20172018")
  end

  def test_it_can_get_worst_coach
    assert_equal "Todd Richards", @season_stats.worst_coach("20122013")
    assert_equal "Mike Babcock", @season_stats.worst_coach("20132014")
    assert_equal "Gerard Gallant", @season_stats.worst_coach("20142015")
    assert_equal "Peter Laviolette", @season_stats.worst_coach("20152016")
    assert_equal "Bill Peters", @season_stats.worst_coach("20162017")
    assert_equal "Bill Peters", @season_stats.worst_coach("20172018")
  end

  def test_accuracy_by_game_team
    assert_instance_of Hash, @season_stats.accuracy_by_game_team("20122013")
    assert_instance_of Hash, @season_stats.accuracy_by_game_team("20132014")
  end

  def test_most_accurate_team
    assert_equal "Utah Royals FC", @season_stats.most_accurate_team("20122013")
    assert_equal "Philadelphia Union", @season_stats.most_accurate_team("20132014")
    assert_equal "Vancouver Whitecaps FC", @season_stats.most_accurate_team("20142015")
    assert_equal "Washington Spirit FC", @season_stats.most_accurate_team("20152016")
    assert_equal "New England Revolution", @season_stats.most_accurate_team("20162017")
    assert_equal "North Carolina Courage", @season_stats.most_accurate_team("20172018")
  end

  def test_least_accurate_team
    assert_equal "Seattle Sounders FC", @season_stats.least_accurate_team("20122013")
    assert_equal "Philadelphia Union", @season_stats.least_accurate_team("20132014")
    assert_equal "Orlando Pride", @season_stats.least_accurate_team("20142015")
    assert_equal "Utah Royals FC", @season_stats.least_accurate_team("20152016")
    assert_equal "Chicago Red Stars", @season_stats.least_accurate_team("20162017")
    assert_equal "Sky Blue FC", @season_stats.least_accurate_team("20172018")
  end

  def test_it_can_get_team_with_most_tackles
    assert_equal "North Carolina Courage", @season_stats.most_tackles("20122013")
    assert_equal "Real Salt Lake", @season_stats.most_tackles("20132014")
    assert_equal "Orlando Pride", @season_stats.most_tackles("20142015")
    assert_equal "Los Angeles FC", @season_stats.most_tackles("20152016")
    assert_equal "Portland Thorns FC", @season_stats.most_tackles("20162017")
    assert_equal "Seattle Sounders FC", @season_stats.most_tackles("20172018")
  end

  def test_it_can_get_team_with_fewest_tackles
    assert_equal "Toronto FC", @season_stats.fewest_tackles("20122013")
    assert_equal "Minnesota United FC", @season_stats.fewest_tackles("20132014")
    assert_equal "New York Red Bulls", @season_stats.fewest_tackles("20142015")
    assert_equal "Sky Blue FC", @season_stats.fewest_tackles("20152016")
    assert_equal "Orlando City SC", @season_stats.fewest_tackles("20162017")
    assert_equal "Sky Blue FC", @season_stats.fewest_tackles("20172018")
  end
end
