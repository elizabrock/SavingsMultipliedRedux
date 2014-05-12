class AuctionClothingSize < ActiveRecord::Base
  belongs_to :auction
  belongs_to :clothing_size
end
