class CouponsController < ApplicationController

  before_filter :check_current_authorized_user_is_a_customer

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = current_authorized_user.coupons.includes(:deal).order('redeemed')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    tweet = TwitterMessaging.new(session[:token], session[:secret]).send_tweet(params[:tweet])
    
    params[:coupon] = { deal_id: session[:deal_id], followers: tweet[:user][:followers_count], redeemed: false, referred: session[:referred], tweet: params[:tweet] }
    @coupon = current_authorized_user.coupons.new(params[:coupon])

    respond_to do |format|
      if @coupon.save
        session[:deal_id] = nil
        session[:referred] = nil
        format.html { redirect_to @coupon.deal notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(redeemed: params[:redeemed])
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end

  private

    def check_current_authorized_user_is_a_customer
      redirect_to root_url unless current_authorized_user.user? 
    end

end
