class AddArtworkUrlToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :artwork_url, :string
  end
end
