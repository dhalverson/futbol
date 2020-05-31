class Team

  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :link

  def initialize(team_params)
    @team_id = team_params[:team_id]
    @franchiseid = team_params[:franchiseid]
    @teamname = team_params[:teamname]
    @abbreviation = team_params[:abbreviation]
    @link = team_params[:link]
  end
end
