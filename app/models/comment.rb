class Comment
  attr_reader :author,
              :score,
              :body,
              :id,
              :replies
  def initialize(data)
    @author = data[:author]
    @score = data[:score]
    @body = data[:body]
    @id = data[:id]
    @replies = []
  end
end
