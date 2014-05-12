require 'spec_helper'

describe AuctionClothingSize do
  it { should belong_to :auction }
  it { should belong_to :clothing_size }
end
