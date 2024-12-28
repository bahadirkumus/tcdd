class VibesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_vibe, only: [:show, :destroy]
  def index
    @vibes = Vibe.includes(video_attachment: :blob).order(created_at: :desc)
  end
  def show
    @vibe = Vibe.find(params[:id])
  end
  def new
    @vibe = Vibe.new
  end
  def create
    @vibe = current_user.vibes.build(vibe_params)
    if @vibe.save
      redirect_to vibes_path, notice: "Vibe başarıyla oluşturuldu!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @vibe.destroy
    redirect_to vibes_path, notice: "Vibe silindi."
  end
  private
  def set_vibe
    @vibe = Vibe.find(params[:id])
  end
  def vibe_params
    params.require(:vibe).permit(:caption, :video)
  end
end