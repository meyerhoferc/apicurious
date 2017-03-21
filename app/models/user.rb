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
end
