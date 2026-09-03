class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

def index
  @featured_tags = ["盛り上がる", "落ち着く", "年代問わず", "友達とカラオケ", "一人カラオケ向け", "デート向け"]

  @tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  @selected_tags = []

  if params[:tag_ids]
    @tweets = []
    params[:tag_ids].each do |key, value|      
      tag = Tag.find_by(name: key)
      if tag && value == "1"
        @tweets += tag.tweets
        @selected_tags << tag.name
      end
    end
    @tweets = @tweets.uniq.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  end

  # ページネーション処理
  @per_page = 10
  @total_pages = (@tweets.size / @per_page.to_f).ceil
  @current_page = (params[:page] || 1).to_i
  @current_page = 1 if @current_page < 1
  @current_page = @total_pages if @total_pages > 0 && @current_page > @total_pages

  offset = (@current_page - 1) * @per_page
  @tweets = @tweets[offset, @per_page] || []
end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id  
    if tweet.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def show
  @tweet = Tweet.find(params[:id])
  @poster_other_tweets = @tweet.user.tweets.where.not(id: @tweet.id).limit(3)
  @similar_artist_tweets = Tweet.where(artist: @tweet.artist)
                                 .where.not(id: @tweet.id)
                                 .sort_by { |t| -t.likes.count }
                                 .first(5)
end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:song_name, :artist, :year, tag_ids: [])
  end

end