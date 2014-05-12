require 'spec_helper'

describe AuctionChildConfiguration do
  it { should belong_to :auction }
  it { should belong_to :child_configuration }
end
