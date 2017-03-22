class User < ApplicationRecord
  def self.from_reddit(user_data, access_token, refresh_token)
    user = User.find_or_create_by(uid: user_data["uid"], provider: 'reddit')
    user.username       = user_data["name"]
    user.access_token   = access_token
    user.refresh_token  = refresh_token
    user.comment_karma = user_data["comment_karma"]
    user.post_karma = user_data["link_karma"]
    user.save

    user
  end

  def reddit_service
    @reddit_service ||= RedditService.new(self.access_token)
  end

  def subreddit_subscriptions
    if reddit_service.subreddits
      reddit_service.subreddits.map do |subreddit|
        Subreddit.new(subreddit[:data][:title], subreddit[:data][:url], subreddit[:data][:public_description])
      end
    end
  end

  def refresh_tokens
    reddit_service.refresh_access_token(self.refresh_token)[:access_token]
  end
end
