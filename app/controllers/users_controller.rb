class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @active_tab = params[:tab].presence_in(%w[posted liked want-to-sing]) || "posted"
    @per_page = 10

    posted_tweets = @user.tweets
    liked_tweets = @user.liked_tweets
    want_to_sing_tweets = @user.want_to_sing_tweets

    @posted_total_pages = (posted_tweets.size / @per_page.to_f).ceil
    @liked_total_pages = (liked_tweets.size / @per_page.to_f).ceil
    @want_to_sing_total_pages = (want_to_sing_tweets.size / @per_page.to_f).ceil

    current_page = (params[:page] || 1).to_i
    current_page = 1 if current_page < 1

    case @active_tab
    when "posted"
      @current_page = current_page > @posted_total_pages && @posted_total_pages > 0 ? @posted_total_pages : current_page
    when "liked"
      @current_page = current_page > @liked_total_pages && @liked_total_pages > 0 ? @liked_total_pages : current_page
    when "want-to-sing"
      @current_page = current_page > @want_to_sing_total_pages && @want_to_sing_total_pages > 0 ? @want_to_sing_total_pages : current_page
    end

    offset = (@current_page - 1) * @per_page

    @posted_tweets_page = posted_tweets[offset, @per_page] || []
    @liked_tweets_page = liked_tweets[offset, @per_page] || []
    @want_to_sing_tweets_page = want_to_sing_tweets[offset, @per_page] || []
  end
end