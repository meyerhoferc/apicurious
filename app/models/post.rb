class Post
  def initialize(contents)
    @contents = contents
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
