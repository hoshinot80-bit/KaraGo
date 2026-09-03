class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :song_name
      t.string :artist
      t.date :year

      t.timestamps
    end
  end
end
