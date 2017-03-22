class SubredditsController < ApplicationController
  def show
    @subreddit = Subreddit.new(params[:id])
    @subreddit.update_url
    @subreddit.update_description
    @subreddit
  end
end
