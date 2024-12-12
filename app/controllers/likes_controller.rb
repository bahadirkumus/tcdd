class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable

  def create
    unless @likeable.likes.exists?(user_id: current_user.id)
      @likeable.likes.create(user: current_user)
    end

    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.js   # create.js.erb çağrılır
    end
  end

  def destroy
    like = @likeable.likes.find_by(user: current_user)
    like&.destroy

    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.js   # destroy.js.erb çağrılır
    end
  end

  private

  def find_likeable
    if params[:movement_id]
      @likeable = Movement.find(params[:movement_id])
    elsif params[:vibe_id]
      @likeable = Vibe.find(params[:vibe_id])
    else
      head :bad_request
    end
  end
end
