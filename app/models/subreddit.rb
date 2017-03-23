class Subreddit
  attr_reader :title, :rules
  attr_accessor :url, :description, :about

  def initialize(title, url = nil, description = nil)
    @title = title
    @url = url
    @description = description
    @about = nil
    @reddit_service = RedditService.new()
    @rules = []
  end

  def update_attributes
    attributes = @reddit_service.get_subreddit_attributes(@title)
    @about = attributes[:description]
    @url = attributes[:url]
    @description = attributes[:public_description]
  end

  def get_rules
    @reddit_service.get_subreddit_rules(@title).each do |rule|
      @rules << Rule.new(rule[:description])
    end
  end

  def posts
    @reddit_service.get_hot_posts(@title).map do |post|
      Post.new(title: post[:data][:title],
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
