class Subreddit
  attr_reader :title, :rules
  attr_accessor :url, :description

  def initialize(title, url = nil, description = nil)
    @title = title
    @url = url
    @description = description
    @reddit_service = RedditService.new()
    @rules = []
  end

  def update_url
    @url = @reddit_service.get_subreddit_url(@title)
  end

  def update_description
    @description = @reddit_service.get_subreddit_description(@title)
  end

  def get_rules
    @reddit_service.get_subreddit_rules(@title).each do |rule|
      @rules << Rule.new(rule[:description])
    end
  end

  def welcome_message
   @reddit_service.get_subreddit_about(@title)
  end

  def posts
    @reddit_service.get_hot_posts(@title)
  end
end
