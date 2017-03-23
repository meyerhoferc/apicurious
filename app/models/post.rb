require 'htmlentities'
class Post
  attr_reader :coder
  def initialize(contents)
    @contents = contents
    @reddit_service = RedditService.new()
    @coder = HTMLEntities.new
  end

  def update_attributes
    attributes = @reddit_service.get_post_attributes(self.id, self.subreddit)
    @contents[:title] = attributes[:title]
    @contents[:num_comments] = attributes[:num_comments]
    @contents[:score] = attributes[:score]
    @contents[:author] = attributes[:author]
    @contents[:text] = attributes[:selftext_html]
    @contents[:url] = attributes[:url]
  end

  def decode_text
    @coder.decode(text)
  end

  def title
    @contents[:title]
  end

  def num_comments
    @contents[:num_comments]
  end

  def score
    @contents[:score]
  end

  def subreddit
    @contents[:subreddit]
  end

  def id
    @contents[:id]
  end

  def author
    @contents[:author]
  end

  def url
    @contents[:url]
  end

  def text
    @contents[:text]
  end

  def text_post?
    text != "null"
  end
end
