class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :uid
      t.string :access_token
      t.string :refresh_token
      t.string :provider
      t.string :comment_karma
      t.string :post_karma

      t.timestamps
    end
  end
end
