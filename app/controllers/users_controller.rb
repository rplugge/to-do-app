class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    user_password = BCrypt::Password.create(params[:user][:password])
    params[:user][:password] = user_password
    
    @user = User.new(user_params)
    
    if @user.save
      redirect_to user_path(@user.id)
    else
      render "new" 
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    
    redirect_to users_path
  end
  
  def login
    if session[:id]
      redirect_to users_path
    end
  end
  
  def login_verification
    @user = User.where(email: params[:user][:email]).first

    binding.pry
    user_password = BCrypt::Password.new(params[:user][:password])
  end
  
  private
  
  def user_params
    params[:user].permit(:name, :email, :password)
  end
end
