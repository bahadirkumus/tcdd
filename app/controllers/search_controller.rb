class SearchController < ApplicationController
  def results
    if params[:query].present?
      @results = User.where("username LIKE ?", "%#{params[:query]}%")
    else
      @results = User.none
    end
  end
end