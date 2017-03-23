class PostsController < ApplicationController
  def show
    @post = Post.new(id: params[:id], subreddit: params[:subreddit_id])
    @post.update_attributes
    @post.fetch_comments
    @subreddit = Subreddit.new(params[:subreddit_id])
    @subreddit.update_attributes
  end
end
