class ChirpsController < ApplicationController

  def index
    if params[:user_id]
      # user = User.find(params[:user_id])
      # chirps = user.chirps
      @chirps = Chirp.where(author_id: params[:user_id]).includes(:author)
    else
      @chirps = Chirp.all.includes(:author)
    end
    render :index
  end

  def new
    render :new
  end

  def create
    @chirp = Chirp.new(chirp_params)
    @chirp.author_id = current_user.id

    if @chirp.save!
      redirect_to chirps_url
    else
      flash.now[:errors] = @chirp.errors.full_messages
      render :new
    end
  end

  private

  def chirp_params
    params.require(:chirp).permit(:body)
  end
  
end
