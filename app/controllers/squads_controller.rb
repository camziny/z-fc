class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :edit, :update, :destroy]

  def index
    @my_squads = current_user.squads.order(created_at: :desc)
    @user_squads = Squad.where.not(user_id: current_user.id).order(created_at: :desc)
  end

  def show
  end

  def new
    if session[:squad_id]
      @squad = current_user.squads.find_by(id: session[:squad_id])
    end
  
    unless @squad
      @squad = current_user.squads.create
      session[:squad_id] = @squad.id
    end
  end
  

  def create
    @squad = Squad.new(squad_params)
    if @squad.save
      redirect_to @squad, notice: 'Squad was successfully created.'
    else
      render :new
    end
  end

  def edit
    @squad = Squad.find(params[:id])
  end
  

  def update
    puts "Debug: Params - #{params.inspect}"
    if @squad.update(squad_params)
      redirect_to @squad, notice: 'Squad was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @squad.destroy
    redirect_to squads_url, notice: 'Squad was successfully destroyed.'
  end

  private

  def set_squad
    @squad = Squad.find(params[:id])
    puts "Debug: #{@squad.inspect}"
  end

  def squad_params
    params.require(:squad).permit(:name, :user_id, squad_players_attributes: [:id, :player_id, :position, :_destroy])
  end  
end

