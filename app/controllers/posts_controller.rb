class PostsController < ApplicationController
  def show
    @post = Post.new(id: params[:id], subreddit: params[:subreddit])
    @post.update_attributes
  end
end
