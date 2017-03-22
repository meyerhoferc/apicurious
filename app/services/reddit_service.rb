class RedditService
  def initialize(token = nil)
    @token = token
    @headers = {Authorization: "bearer #{@token}", "User-Agent": "apicurious by razzpudding"}
  end

  def subreddits
    response = HTTParty.get("https://oauth.reddit.com/subreddits/mine/subscriber", headers: @headers)
    parse(response)[:data][:children] if response["error"] == nil
  end

  def refresh_access_token(refresh_token)
    response = HTTParty.post("https://www.reddit.com/api/v1/access_token",
                            body: "grant_type=refresh_token&refresh_token=#{refresh_token}&redirect_uri=#{ENV['REDIRECT_URI']}",
                            basic_auth: { username: ENV['REDDIT_KEY'], password: ENV['REDDIT_SECRET'] })
    parse(response)
  end

  def get_subreddit_url(title)
    response = HTTParty.get("https://www.reddit.com/r/#{title}/about.json")
    parse(response)[:data][:url]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
