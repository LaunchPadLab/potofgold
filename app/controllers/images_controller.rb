class ImagesController < ApplicationController

  before_filter :check_current_authorized_user_is_an_advertiser

  # POST /images
  # POST /images.json
  def create
    @image = current_authorized_user.images.new(params[:image])

    respond_to do |format|
      if @image.save
        format.js
      else
        format.js
      end
    end
  end

  private

    def check_current_authorized_user_is_an_advertiser
      redirect_to root_url unless current_authorized_user.advertiser? 
    end

end
