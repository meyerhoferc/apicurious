class RedditOauth
  attr_reader :refresh_token
  def initialize(code)
    @code = code
  end

  def access_token
    response = HTTParty.post("https://www.reddit.com/api/v1/access_token",
      body: "grant_type=authorization_code&code=#{@code}&redirect_uri=#{ENV['REDIRECT_URI']}",
      basic_auth: { username: ENV['REDDIT_KEY'], password: ENV['REDDIT_SECRET'] })
    @refresh_token = JSON.parse(response.body)["refresh_token"]
    @access_token = JSON.parse(response.body)["access_token"]
  end

  def user_data
    user_data = HTTParty.get("https://oauth.reddit.com/api/v1/me",
                             headers: { Authorization: "bearer #{@access_token}",
                                        "User-Agent": "apicurious by razzpudding"})
  end
end
