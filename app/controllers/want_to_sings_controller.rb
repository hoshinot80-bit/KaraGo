class WantToSingsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.want_to_sings.create(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    want_to_sing = WantToSing.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    want_to_sing.destroy
    redirect_back(fallback_location: root_path)
  end
end