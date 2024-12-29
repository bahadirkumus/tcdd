class MovementsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in
  before_action :set_movement, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @movements = Movement.includes(:user, comments: [:user]).all
  end

  def new
    @movement = Movement.new
  end

  def create
    @movement = current_user.movements.build(movement_params)
    if @movement.save
      redirect_to movements_path, notice: "Post created!"
    else
      render :new, alert: "Error!"
    end
  end

  def edit
    # @movement is already set by the set_movement callback
  end

  def update
    if @movement.update(movement_params)
      redirect_to movements_path, notice: "Post updated!"
    else
      render :edit, alert: "Error!"
    end
  end

  def show
    @movement = Movement.find(params[:id])
    @comments = @movement.comments.includes(:user)
  end

  def destroy
    @movement.destroy
    redirect_to movements_path, notice: "Post deleted!"
  end

  private

  def movement_params
    params.require(:movement).permit(:content, :image)
  end

  def set_movement
    @movement = Movement.find(params[:id])
  end

  def authorize_user!
    unless @movement.user == current_user
      redirect_to movements_path, alert: "You are not authorized to perform this action."
    end
  end
end
