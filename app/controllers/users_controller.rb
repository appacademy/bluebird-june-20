class UsersController < ApplicationController

  before_action :require_logged_in, only: [:index]
  before_action :require_logged_out, only: [:new, :create]
  
  def index
    @users = User.all
    # render json: @users
    render :index
  end

  def show
    # need to use instance variables so they show up in our views!
    @user = User.find(params[:id])
    # render json: user
    render :show
  end

  def new
    @user = User.new
    # make a blank user
    render :new
  end

  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
      # after user is successfully created, send the client to the show page 
      # for the user that was just created 
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
      # render json: @user.errors.full_messages, status: 422
    end
  end

  def edit
    # debugger
    @user = User.find(params[:id])
    # implicitly rendering :edit
    # because our action is called edit
    # rails will look for a view called edit.html.erb
  end

  def update
    # debugger
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to "/users/#{@user.id}"
    else
      render json: @user.errors.full_messages, status: 422
    end
    
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    # render json: @user
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :age, :political_affiliation, :password)
  end
  
end
