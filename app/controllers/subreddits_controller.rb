class SubredditsController < ApplicationController
  def show
    @subreddit = Subreddit.new(params[:id])
    @subreddit.update_attributes
    @subreddit.get_rules
  end
end
