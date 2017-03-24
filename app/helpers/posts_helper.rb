module PostsHelper
  def create_nested_comments(comment)
    html = content_tag(:ul, class: "collection") do
      ul_contents = ""

      ul_contents << content_tag(:li, class: "comment comment_#{comment.depth}") do
        content_tag(:p, "#{comment.author} [#{comment.score} points]", id: "comment_info") + content_tag(:p, "#{comment.body}", id: "comment_#{comment.id}")
      end
      if comment.replies.count > 0
        comment.replies.each { |reply| ul_contents << create_nested_comments(reply) }
      end
      ul_contents.html_safe
    end.html_safe
  end
end
