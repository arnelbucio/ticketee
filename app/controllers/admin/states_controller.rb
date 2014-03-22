class Admin::StatesController < ApplicationController
  before_action :set_state, only: [:edit, :destroy, :make_default]
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)
    if @state.save
      flash[:notice] = "State has been created."
      redirect_to admin_states_path
    else
      flash[:alert] = "State has not been created."
      render :new
    end
  end

  def edit
  end

  def update
    @state = State.new(state_params)
    if @state.save
      flash[:notice] = "State has been updated."
      redirect_to admin_states_path
    else
      flash[:alert] = "State has not been updated."
      render :edit
    end
  end

  def destroy
    @state.destroy
    flash[:notice] = "State has been deleted."
    redirect_to admin_states_path
  end

  def make_default
    @state.default!

    flash[:notice] = "#{@state.name} is now the default state."
    redirect_to admin_states_path
  end

  private
    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:name)
    end
end
