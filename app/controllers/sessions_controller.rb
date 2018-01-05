class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    user.reset_session_token! if user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
