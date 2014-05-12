class AuctionChildConfiguration < ActiveRecord::Base
  belongs_to :auction
  belongs_to :child_configuration
end
