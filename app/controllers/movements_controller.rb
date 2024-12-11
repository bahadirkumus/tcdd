class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movements = Movement.all.order(created_at: :desc)
  end

  def new
    @movement = Movement.new
  end

  def create
    @movement = current_user.movements.build(movement_params)
    if @movement.save
      redirect_to movements_path, notice: "Post başarıyla oluşturuldu!"
    else
      render :new, alert: "Post oluşturulamadı!"
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:content, :image)
  end
end
