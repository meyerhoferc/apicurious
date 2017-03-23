class Subreddit
  attr_reader :title, :rules, :hot_posts
  attr_accessor :url, :description

  def initialize(title, url = nil, description = nil)
    @title = title
    @url = url
    @description = description
    @reddit_service = RedditService.new()
    @rules = []
    @hot_posts = []
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
    @reddit_service.get_hot_posts(@title).each do |post|
      @hot_posts << Post.new(title: post[:data][:title],
                             num_comments: post[:data][:num_comments],
                             score: post[:data][:score],
                             subreddit: post[:data][:subreddit_name_prefixed],
                             id: post[:data][:id],
                             author: post[:data][:author],
                             url: post[:data][:url],
                             text: post[:data][:selftext_html])
    end
  end
end
