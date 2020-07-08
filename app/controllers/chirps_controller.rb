class ChirpsController < ApplicationController

  def index
    if params[:user_id]
      # user = User.find(params[:user_id])
      # chirps = user.chirps
      chirps = Chirp.where(author_id: params[:user_id])
    else
      chirps = Chirp.all
    end
    render json: chirps
  end
  
end
