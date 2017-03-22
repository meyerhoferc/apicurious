class RedditService
  def initialize(token)
    @token = token
    @headers = {Authorization: "bearer #{@token}", "User-Agent": "apicurious by razzpudding"}
  end

  def subreddits
    response = HTTParty.get("https://oauth.reddit.com/subreddits/mine/subscriber", headers: @headers)
    parse(response)[:data][:children] if response["error"] == 200
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
