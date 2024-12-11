class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movement = Movement.find(params[:movement_id])
    unless @movement.likes.exists?(user_id: current_user.id)
      @movement.likes.create(user: current_user)
    end

    respond_to do |format|
      format.html { redirect_to movements_path }
      format.js   # AJAX çağrısını desteklemek için
    end
  end

  def destroy
    @movement = Movement.find(params[:movement_id])
    like = @movement.likes.find_by(user: current_user)
    like&.destroy

    respond_to do |format|
      format.html { redirect_to movements_path }
      format.js   # AJAX çağrısını desteklemek için
    end
  end
end
