class AddYoutubeUrlToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :youtube_url, :string
  end
end
