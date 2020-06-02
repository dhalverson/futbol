require 'CSV'
require_relative 'game'

class GameCollection

  @@all = []

  def from_csv(games_file_path)
    games = CSV.read(games_file_path, headers: true, header_converters: :symbol)
    all_games = games.map do |row|
      Game.new(row)
    end
    @@all = all_games
  end

  def self.all
    @@all
  end

  attr_reader :games

  def initialize(games_file_path)
    @games = from_csv(games_file_path)
  end
end
