class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movement

  def create
    @comment = @movement.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @movement, notice: "Yorum başarıyla eklendi." }
        format.js # create.js.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @movement, alert: "Yorum eklenemedi." }
        format.js
      end
    end
  end

  def destroy
    @comment = @movement.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @movement, notice: "Yorum silindi." }
      format.js # destroy.js.erb
    end
  end

  private

  def set_movement
    @movement = Movement.find(params[:movement_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
