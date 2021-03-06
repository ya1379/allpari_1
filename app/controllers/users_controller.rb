class UsersController < ApplicationController
  layout :user_layout
 
  
    
  def new
    @user = User.new
  end
  def show
    
    @user = User.find(params[:id])
    
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to signin_path
      flash[:success] = "Welcome to the Sample App!"
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
    
    def user_layout
      signed_in? ? "application" : "new"
    end
end
