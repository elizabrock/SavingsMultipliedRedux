require 'spec_helper'

feature "User views an auction" do
  # In order to inspect an item before purchasing it
  # As a person viewing the site
  # I want to view the full details of an item

  # Includes:
  # - image
  # - auction seller (with link to profile)
  # - auction ending time
  # - current auctions show count down with full date.  e.g. 4 hours (12/5/2010 8:00 PM)
  # - ended auctions show only the ending time (either the auction ending time or the moment it was "buy now"'d)
  # - opening bid/current bid/final price (as applicable)
  # - buy it now price
  # - if the auction has ended, who won it
  # - auction description
  # - size/gender/season/brand/condition information

  background do
    pending "implementation"
  end

  scenario "an auction in general" do
    bob = Fabricate(:user, first_name: "Bob", last_name: "Burger")
    twins_mm = Fabricate(:child_configuration, genders: "mm", siblings_type: "twins")
    zoot_suits = Fabricate(:active_auction,
                            title: "zoot suits",
                            user: bob,
                            brand: Fabricate(:brand, "Janie & Jack"),
                            child_configurations: [ twins_mm ],
                            clothing_size: Fabricate(:size, name: "3M"),
                            season: Fabricate(:season, name: "fall"),
                            clothing_condition: Fabricate(:clothing_condition, name: "new"),
                            description: "Awesome suits",
                            starting_price: 11)
    visit auction_path(zoot_suits)
    within(".auction") do
      page.should have_css("h1, h2, h3", text: "zoot suits")
      page.should have_css(".seller_name", text: "Bob B.")
      page.should have_css(".brand", text: "Janie & Jack")
      page.should have_css(".child_icons.mm")
      page.should have_css(".sizes", text: "3M", within: ".sizes")
      page.should have_css(".seasons", text: "fall", within: ".seasons")
      page.should have_css(".condition", text: "new", within: ".condition")
      page.should have_css(".description", text: "Awesome suits", within: ".description")
      page.should have_css(".price", text: "$11")
      click_link "Bob B."
    end
    current_path.should == user_path(bob)
  end

  scenario "a finished auction that was won" do
    sailor_suits = Fabricate(:ended_auction, title: "3 sailor suits", starting_price: "24")
    # And the "3 sailor suits" auction has been bought out by "Janet Jackson"
    visit auction_path(sailor_suits)
    page.should_not have_content "Bid Now"
    page.should have_content "Sold On: December 10, 2010 13:45 PST"
    page.should have_css(".final_price", "$24.00")
    page.should_not have_content "Janet J."
  end

  scenario "a finished auction that wasn't bid on" do
    sailor_suits = Fabricate(:ended_auction, title: "3 sailor suits", starting_price: "24")
    visit auction_path(sailor_suits)
    page.should_not have_content "Bid Now"
    page.should have_content "Ended At: December 10, 2010 13:45 PST"
    page.should have_css(".final_price", "$24.00")
    page.should_not have_content "Janet J."
  end

  scenario "an ongoing auction" do
    sailor_suits = Fabricate(:active_auction, title: "3 sailor suits", starting_price: "24")
    visit auction_path(sailor_suits)
    page.should_not have_content "bidder"
    page.should have_content "Buy Now"
  end
end
