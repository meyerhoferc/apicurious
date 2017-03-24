require 'htmlentities'
class Post
  attr_reader :coder, :comments
  def initialize(contents)
    @contents = contents
    @reddit_service = RedditService.new()
    @coder = HTMLEntities.new
    @comments = []
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

  def fetch_comments
    @reddit_service.get_comments_for_post(self.id, self.subreddit).each do |comment|
      insert_comment(comment)
    end
  end

  def insert_comment(comment_data, parent_comment = nil)
    comment = Comment.new(comment_data[:data])
    add_to_parent(comment, parent_comment)
    add_to_parent_comments(comment, parent_comment, comment_data)
    add_children_to_current_comment(comment, comment_data)
  end

  def add_to_parent(comment, parent_comment)
    if parent_comment
      parent_comment.replies << comment
    end
  end

  def add_to_parent_comments(comment, parent_comment, comment_data)
    if parent_comment == nil && comment_data[:kind] != "more"
      @comments << comment
    end
  end

  def add_children_to_current_comment(comment, comment_data)
    if comment_data[:data][:replies] != "" && comment_data[:kind] != "more"
      replies = comment_data[:data][:replies][:data][:children]
      replies.each do |reply|
        insert_comment(reply, comment)
      end
    end
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
