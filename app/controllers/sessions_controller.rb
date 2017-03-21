class SessionsController < ApplicationController
  def create
    response = HTTParty.post("https://www.reddit.com/api/v1/access_token",
      body: "grant_type=authorization_code&code=#{params[:code]}&redirect_uri=#{ENV['REDIRECT_URI']}",
      basic_auth: { username: ENV['REDDIT_KEY'], password: ENV['REDDIT_SECRET'] })
    parsed_response = JSON.parse(response.body)
    access_token = parsed_response["access_token"]
    refresh_token = parsed_response["refresh_token"]
    user_data = HTTParty.get("https://oauth.reddit.com/api/v1/me",
                             headers: { Authorization: "bearer #{access_token}",
                                        "User-Agent": "apicurious by razzpudding"})
    user = User.from_reddit(user_data, access_token, refresh_token)
    session[:user_id] = user.id
  end

  private

  def reddit_login_params
    params.permit(:code, :state)
  end
end
