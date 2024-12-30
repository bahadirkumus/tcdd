def show
  @user = User.find_by!(username: params[:username])
  @total_posts = @user.posts.count
  @movements = @user.movements.includes(:user, :likes, :comments).order(created_at: :desc)
  @vibes = @user.vibes.includes(:user, :likes, :comments).with_attached_video.order(created_at: :desc)
  render template: "users/show"
end 