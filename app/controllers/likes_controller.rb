class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movement = Movement.find(params[:movement_id])
    unless @movement.likes.exists?(user_id: current_user.id)
      @movement.likes.create(user: current_user)
      flash[:notice] = "Postu beğendiniz!"
    end
    redirect_to movements_path
  end

  def destroy
    @movement = Movement.find(params[:movement_id])
    like = @movement.likes.find_by(user: current_user)
    if like
      like.destroy
      flash[:alert] = "Beğeni kaldırıldı!"
    end
    redirect_to movements_path
  end
end