require 'CSV'
require_relative 'team'

class TeamCollection

  @@all = []

  def from_csv(teams_file_path)
    teams = CSV.read(teams_file_path, headers: true, header_converters: :symbol)
    all_teams = teams.map do |row|
      Team.new(row)
    end
    @@all = all_teams
  end

  def self.all
    @@all
  end

  attr_reader :teams

  def initialize(teams_file_path)
    @teams = from_csv(teams_file_path)
  end
end
