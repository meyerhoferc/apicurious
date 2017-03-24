class Comment
  attr_reader :author,
              :score,
              :body,
              :id,
              :depth,
              :replies
  def initialize(data)
    @author = data[:author]
    @score = data[:score]
    @body = data[:body]
    @id = data[:id]
    @depth = data[:depth]
    @replies = []
  end
end
