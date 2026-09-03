class StaticPagesController < ApplicationController
  def top
    @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    @featured_tags = ["盛り上がる", "落ち着く", "年代問わず", "友達とカラオケ", "一人カラオケ向け", "デート向け"]
  end
end