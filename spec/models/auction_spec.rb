require 'spec_helper'

describe Auction do
  it { should belong_to :user }
  it { should belong_to :brand }
  it { should belong_to :clothing_condition }
  it { should belong_to :clothing_type }
  it { should belong_to :season }
  it { should have_many :child_configurations }
  it { should have_many :clothing_sizes }
  it { should validate_presence_of :brand }
  it { should validate_presence_of :clothing_condition }
  it { should validate_presence_of :clothing_type }
  it { should validate_presence_of :description }
  it { should validate_presence_of :item_photo }
  it { should validate_presence_of :title }
  it { should validate_presence_of :user }
end
