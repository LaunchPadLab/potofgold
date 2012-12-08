class DealsController < ApplicationController

  def mydeal
  end

  # GET /deals
  # GET /deals.json
  def index
    @deals = current_authorized_user.deals.includes(:coupons)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deals }
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id], include: [:advertiser, :coupons, :users])
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
    @h = LazyHighCharts::HighChart.new('graph', style: '') do |f|
      f.options[:chart][:defaultSeriesType] = "area"
      f.options[:plotOptions] = {areaspline: {pointInterval: 1.day, pointStart: 10.days.ago}}
      f.series(:name=>'Followers', :data=> @deal.followers_array)
      f.xAxis(type: :datetime)
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = current_authorized_user.deals.new(params[:deal])

    respond_to do |format|
      if @deal.save
        format.html { redirect_to deals_url, notice: 'Deal was successfully created.' }
        format.json { render json: @deal, status: :created, location: @deal }
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
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
        format.html { render action: "edit" }
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
end
