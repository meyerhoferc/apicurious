class Subreddit
  attr_reader :title
  attr_accessor :url, :description

  def initialize(title, url = nil, description = nil)
    @title = title
    @url = url
    @description = description
    @reddit_service = RedditService.new()
  end

  def update_url
    @url = @reddit_service.get_subreddit_url(@title)
  end
end
