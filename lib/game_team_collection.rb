require 'CSV'
require_relative 'game_team'

class GameTeamCollection

  @@all = []

  def from_csv(game_teams_file_path)
    game_teams = CSV.read(game_teams_file_path, headers: true, header_converters: :symbol)
    all_game_teams = game_teams.map do |row|
      GameTeam.new(row)
    end
    @all = all_game_teams
  end

  def self.all
    @@all
  end

  attr_reader :game_teams

  def initialize(game_teams_file_path)
    @game_teams = from_csv(game_teams_file_path)
  end
end
