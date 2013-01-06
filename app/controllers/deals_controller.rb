class DealsController < ApplicationController

  before_filter :check_current_authorized_user_is_an_advertiser, except: [:show]
  before_filter :check_current_authorized_user_created_deal, only: [:show]

  # GET /deals
  # GET /deals.json
  def index
    @deals = current_authorized_user.deals.includes(:coupons).order('end_date ASC')
    @deals_total_followers = @deals.map { |d| d.followers }.total

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deals }
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id], include: [:advertiser, :coupons, :users, :image])
    session[:referred] = true if params[:referred]
    session[:deal_id] = @deal.id unless current_authorized_user
    @coupon = @deal.coupons.for_user(current_authorized_user).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal }
    end
  end

  def stats
    @deal = Deal.find(params[:id], include: [:advertiser, :coupons, :users])

    grouped_coupons = @deal.coupons.oldest.group_by { |c| c.created_at.strftime('%D') }
    prev = 0
    arr = grouped_coupons.values.map { |coupons| coupons.map { |c| c.followers}.total }.collect { |value| prev += value }

    @h = LazyHighCharts::HighChart.new('graph', style: '') do |f|
      f.options[:title][:text] = 'Who\'s seen it?'
      f.options[:legend][:enabled] = false
      f.options[:chart][:defaultSeriesType] = "area"
      f.options[:plotOptions] = {areaspline: {pointStart: @deal.created_at }}
      f.options[:xAxis][:type] = "datetime"
      f.series(:name=>'Followers', :data=> arr)
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new
    @images = current_authorized_user.images
    @default_images = Image.order('created_at ASC').limit(6)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
    @images = current_authorized_user.images
    @default_images = Image.order('created_at ASC').limit(6)
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = current_authorized_user.deals.new(params[:deal])

    respond_to do |format|
      if @deal.save
        format.json { render json: @deal }
      else
        format.json { render json: { error: 'There was an error!' } }
      end
    end
  end

  # POST /tweet
  def tweet
    TwitterMessaging.new(session[:token], session[:secret]).send_tweet(params[:tweet])

    redirect_to deals_url, notice: 'You just started a new deal. Good luck!'

  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        @images = current_authorized_user.images
        @default_images = Image.order('created_at ASC').limit(6)
        format.html { render action: "edit", alert: 'Deal not updated!' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :no_content }
    end
  end

  private

    def check_current_authorized_user_is_an_advertiser
      redirect_to root_url unless current_authorized_user.advertiser?
    end

    def check_current_authorized_user_created_deal
      if current_authorized_user
        redirect_to root_url if current_authorized_user.advertiser? && current_authorized_user.not_create_deal?(params[:id])
      end
    end

end
