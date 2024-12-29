class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to request.referer || root_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer || root_path, alert: "Yorum eklenemedi." }
        format.js
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])

    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to request.referer || root_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer || root_path, alert: "Yorum silinemedi." }
        format.js
      end
    end
  end

  private

  def find_commentable
    if params[:vibe_id]
      @commentable = Vibe.find(params[:vibe_id])
    elsif params[:movement_id]
      @commentable = Movement.find(params[:movement_id])
    else
      head :bad_request
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end