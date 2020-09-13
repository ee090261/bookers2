class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user,{only:[:edit]}

  def index
   @user = current_user
   @new_book = Book.new
   @users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show
  	@new_book = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books
  end

  def authenticate_user
    user=User.find(params[:id])
    if user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end

