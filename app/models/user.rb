class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :want_to_sings, dependent: :destroy
  has_many :want_to_sing_tweets, through: :want_to_sings, source: :tweet
  has_one_attached :avatar

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  def already_want_to_sing?(tweet)
    self.want_to_sings.exists?(tweet_id: tweet.id)
  end
end