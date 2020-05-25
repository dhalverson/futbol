class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_params)
    @team_id = team_params[:team_id]
    @franchise_id = team_params[:franchise_id]
    @team_name = team_params[:team_name]
    @abbreviation = team_params[:abbreviation]
    @stadium = team_params[:stadium]
    @link = team_params[:link]
  end
end
