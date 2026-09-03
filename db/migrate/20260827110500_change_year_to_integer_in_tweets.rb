class ChangeYearToIntegerInTweets < ActiveRecord::Migration[7.2]
  def up
    add_column :tweets, :year_int, :integer

    Tweet.reset_column_information
    Tweet.find_each do |tweet|
      if tweet.year.present?
        tweet.update_column(:year_int, tweet.year.year)
      end
    end

    remove_column :tweets, :year
    rename_column :tweets, :year_int, :year
  end

  def down
    add_column :tweets, :year_date, :date

    Tweet.reset_column_information
    Tweet.find_each do |tweet|
      if tweet.year.present?
        tweet.update_column(:year_date, Date.new(tweet.year, 1, 1))
      end
    end

    remove_column :tweets, :year
    rename_column :tweets, :year_date, :year
  end
end