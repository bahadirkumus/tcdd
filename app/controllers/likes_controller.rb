class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable

  def create
    unless @likeable.likes.exists?(user_id: current_user.id)
      @likeable.likes.create(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream {
        if @likeable.is_a?(Vibe)
          render turbo_stream: [
            turbo_stream.update("like-button-#{@likeable.id}", 
              partial: "vibes/like_button", 
              locals: { vibe: @likeable }
            ),
            turbo_stream.update("like-count-#{@likeable.id}", 
              partial: "vibes/like_count", 
              locals: { vibe: @likeable }
            )
          ]
        end
      }
      format.html { redirect_to request.referer || root_path }
    end
  end

  def destroy
    like = @likeable.likes.find_by(user: current_user)
    like&.destroy

    respond_to do |format|
      format.turbo_stream {
        if @likeable.is_a?(Vibe)
          render turbo_stream: [
            turbo_stream.update("like-button-#{@likeable.id}", 
              partial: "vibes/like_button", 
              locals: { vibe: @likeable }
            ),
            turbo_stream.update("like-count-#{@likeable.id}", 
              partial: "vibes/like_count", 
              locals: { vibe: @likeable }
            )
          ]
        end
      }
      format.html { redirect_to request.referer || root_path }
    end
  end

  private

  def find_likeable
    if params[:vibe_id]
      @likeable = Vibe.find_by(id: params[:vibe_id])
    elsif params[:movement_id]
      @likeable = Movement.find_by(id: params[:movement_id])
    end

    unless @likeable
      Rails.logger.debug("Likeable bulunamadı: vibe_id=#{params[:vibe_id]}, movement_id=#{params[:movement_id]}")
      head :bad_request
    end
  end
end
