require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#refresh_tokens" do
    it "returns a new token for a user" do
      VCR.use_cassette("/models/refresh_token_for_user") do
        access_token = ENV['ACCESS_TOKEN_DUMMY']
        refresh_token = ENV['REFRESH_TOKEN_DUMMY']
        user = Fabricate(:user, access_token: access_token, refresh_token: refresh_token)
        new_access_token = user.refresh_tokens

        expect(new_access_token.class).to eq(String)
        expect(new_access_token).to_not eq(access_token)
        expect(user.access_token).to_not eq(access_token)
        expect(user.access_token).to eq(new_access_token)
      end
    end
  end
end
