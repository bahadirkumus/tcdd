class FolksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @folks = Folk.all
  end

  def show
    @folk = Folk.find(params[:id])
    @movements = @folk.movements
  end

  def new
    @folk = Folk.new
  end

  def create
    @folk = Folk.new(folk_params)
    if @folk.save
      redirect_to @folk, notice: "Group created successfully."
    else
      render :new
    end
  end

  def join
    @folk = Folk.find(params[:id])
  
    # Check if the user is already a member
    if @folk.users.include?(current_user)
      flash[:alert] = "You are already a member of this group."
    else
      # Add the user to the group
      if @folk.folk_memberships.create(user: current_user)
        flash[:notice] = "You have successfully joined the group."
      else
        flash[:alert] = "Something went wrong. Please try again."
      end
    end
  
    redirect_to folk_path(@folk)
  end


  def leave
  @folk = Folk.find(params[:id])

  # Find and destroy the membership
  membership = @folk.folk_memberships.find_by(user: current_user)
  if membership&.destroy
    flash.now[:notice] = "You have successfully left the group."
  else
    flash.now[:alert] = "Something went wrong. Please try again."
  end

  # Respond with Turbo Stream
  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to folk_path(@folk) }
  end
end

  private

  def folk_params
    params.require(:folk).permit(:name, :description)
  end
end
