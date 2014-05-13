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

  context "ends_at" do
    context "on creation" do
      let(:auction){ Fabricate.build(:auction) }
      it "should be set" do
        expect{ auction.save }.to change{ auction.ends_at }.from(nil)
        auction.ends_at.to_i.should be_within(5).of(10.days.from_now.to_i)
      end
    end
    context "on creation, with a value set" do
      let(:auction){ Fabricate.build(:auction, ends_at: 1.day.from_now) }
      it "should be set" do
        expect{ auction.save }.to_not change{ auction.ends_at }
      end
    end
    context "on update" do
      let(:auction){ Fabricate(:auction, ends_at: 1.week.ago) }
      it "should not change" do
        auction.title = "new title"
        expect{ auction.save }.to_not change{ auction.ends_at }
      end
    end
  end
end
