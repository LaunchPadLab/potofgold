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
