class AuctionsController < ApplicationController
  skip_before_filter :authenticate!, only: [:index, :show]

  def index
    @auctions = @auction_search.auctions
  end

  def show
    @auction = Auction.find(params[:id])
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_user.auctions.new(auction_params)
    if @auction.save
      redirect_to @auction, notice: "Your auction has been created."
    else
      flash[:alert] = "Your auction could not be created."
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(
      :brand_id,
      :clothing_condition_id,
      :clothing_type_id,
      :description,
      :item_photo,
      :season_id,
      :starting_price,
      :title,
      :child_configuration_ids => [],
      :clothing_size_ids => [],
    )
  end
end
