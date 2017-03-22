class SessionsController < ApplicationController
  def create
    reddit_oauth = RedditOauth.new(params[:code])
    access_token = reddit_oauth.access_token
    refresh_token = reddit_oauth.refresh_token
    user_data = reddit_oauth.user_data
    user = User.from_reddit(user_data, access_token, refresh_token)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.clear
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def reddit_login_params
    params.permit(:code, :state)
  end
end
