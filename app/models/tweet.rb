require "net/http"
require "json"

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy
  has_many :want_to_sings, dependent: :destroy
  has_many :want_to_sing_users, through: :want_to_sings, source: :user

  validates :song_name, uniqueness: { scope: :artist, message: "とアーティストの組み合わせは既に登録されています" }

  after_create :fetch_artwork

  private

  def fetch_artwork
    query = "#{song_name} #{artist}"
    url = URI("https://itunes.apple.com/search?term=#{URI.encode_www_form_component(query)}&media=music&limit=1")

    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if data["results"].present?
      artwork = data["results"].first["artworkUrl100"]
      # 画像サイズを100x100から600x600に大きくする
      artwork_large = artwork.gsub("100x100bb", "600x600bb")
      update_column(:artwork_url, artwork_large)
    end
  rescue => e
    Rails.logger.error("iTunes API取得失敗: #{e.message}")
  end
end