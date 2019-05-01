class UsersController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update, :destroy]
  before_action :required_same_user, only:[:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Hi #{@user.username}, Welcome to Article blog"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def index
    @users = User.all
  end

  def destroy
  end

  def show
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end


  end


  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def required_same_user
      unless logged_in? && current_user == @user
        flash[:danger] = "You can edit only your account once you logged in"
        redirect_to articles_path
      end
    end

end
