class LeagueTeamsController < ApplicationController
  before_action :set_league_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :edit, :create, :update, :delete]
  respond_to :html, :json

  def index
    if params[:league_id] && params[:team_id]
      @league_teams = LeagueTeam.where(league_id: params[:league_id], team_id: params[:team_id])
    elsif params[:league_id]
      @league_teams = LeagueTeam.where(league_id: params[:league_id])
    else
      @league_teams = LeagueTeam.all
    end
    respond_with @league_teams
  end

  # GET /league_teams/1
  def show
    respond_with @league_team
  end

  # GET /league_teams/new
  def new
    @league_team = LeagueTeam.new
  end

  # GET /league_teams/1/edit
  def edit
  end

  # POST /league_teams
  def create
    @league_team = LeagueTeam.new(league_team_params)
    if @league_team.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @league_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /league_teams/1
  def update
    if @league_team.update(league_team_params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @league_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /league_teams/1
  def destroy
    @league_team.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Team was successfully removed.'}
      format.json { render json: { head: :ok } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league_team
      @league_team = LeagueTeam.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def league_team_params
      params.require(:league_team).permit(:team_id, :league_id, :wins, :losses, :paid, :place)
    end
end

