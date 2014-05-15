require 'spec_helper'

feature "User searches auctions" do
# In order to find auctions that I am interested in
# As a logged in user
# I want to search auctions

# - user enters search term and presses 'search' in the main navbar
# - based on title, description, seller name and brand
# - uses the same auction format as the general auction listing
# - uses the same scoping rules as browsing auctions

  let(:twins_bg){ Fabricate(:child_configuration, siblings_type: "twins", genders: "bg") }
  let(:twins_gg){ Fabricate(:child_configuration, siblings_type: "twins", genders: "gg") }
  let(:siblings_bg){ Fabricate(:child_configuration, siblings_type: "sibling sets", genders: "bg") }
  let(:siblings_gg){ Fabricate(:child_configuration, siblings_type: "sibling sets", genders: "gg") }
  let(:triplets_bbb){ Fabricate(:child_configuration, siblings_type: "triplets", genders: "bbb") }

  let(:active_auctions) do
    Fabricate(:active_auction, title: "bg twin clothes foo", child_configurations: [twins_bg])
    Fabricate(:active_auction, title: "gg twin clothes foo", child_configurations: [twins_gg])
    Fabricate(:active_auction, title: "bg twin clothes bar", child_configurations: [twins_bg])
    Fabricate(:active_auction, title: "bg sibling clothes foo", child_configurations: [siblings_bg])
    Fabricate(:active_auction, title: "gg sibling clothes foo", child_configurations: [siblings_gg, twins_gg])
    Fabricate(:active_auction, title: "bg sibling clothes bar", child_configurations: [siblings_bg])
  end

  scenario "searching for a single word, and using filters" do
    active_auctions
    visit '/'
    click_link "Buy"
    within "header" do
      fill_in "Search", with: "foo"
      click_button "Search"
    end

    page.should have_link "bg twin clothes foo"
    page.should have_link "gg twin clothes foo"
    page.should have_link "bg sibling clothes foo"
    page.should_not have_content "bg twin clothes bar"
    page.should_not have_content "bg sibling clothes bar"

    click_link "twins"
    page.should have_link "bg twin clothes foo"
    page.should have_link "gg twin clothes foo"
    page.should_not have_content "bg sibling clothes foo"
    page.should_not have_content "bg twin clothes bar"
    page.should_not have_content "bg sibling clothes bar"

    click_link "bg"
    page.should have_link "bg twin clothes foo"
    page.should_not have_content "gg twin clothes foo"
    page.should_not have_content "bg sibling clothes foo"
    page.should_not have_content "bg twin clothes bar"
    page.should_not have_content "bg sibling clothes bar"
  end

  scenario "results with a auction in multiple categories are shown only once" do
    active_auctions
    visit '/'
    click_link "Buy"
    within "header" do
      fill_in "Search", with: "foo"
      click_button "Search"
    end
    # This causes an error if it appears more than once:
    find("a", text: "gg sibling clothes foo")
  end

  scenario "searching is based on title, description, brand, and seller" do
    gap_brand = Fabricate(:brand, name: "Gap")
    other_brand = Fabricate(:brand, name: "Other")
    eliza_b = Fabricate(:user, first_name: "Eliza", last_name: "Brock")
    erin_m = Fabricate(:user, first_name: "Erin", last_name: "McDermott")

    Fabricate(:active_auction, title: "bg twin clothes", child_configurations: [twins_bg], brand: gap_brand, user: eliza_b)
    Fabricate(:closed_auction, title: "closed bg twin clothes", child_configurations: [twins_bg], brand: gap_brand, user: eliza_b)
    Fabricate(:active_auction, title: "gg twin clothes", child_configurations: [twins_gg], brand: gap_brand, user: eliza_b)
    Fabricate(:active_auction, title: "bbb triplet clothes", child_configurations: [triplets_bbb], brand: gap_brand, user: eliza_b)
    Fabricate(:active_auction, title: "banana colored shoes", child_configurations: [twins_bg], description: "cherry laces", brand: gap_brand, user: erin_m)
    Fabricate(:active_auction, title: "strawberry hats", child_configurations: [twins_bg], brand: other_brand, user: eliza_b)

    visit '/'
    click_link "Buy"
    click_link "twins"
    click_link "bg"

    within "#auction_search_sidebar" do
      fill_in "Search term", with: "strawberry"
      click_button "Search"
    end
    page.should have_css(".auction a", text: "strawberry hats")

    within "#auction_search_sidebar" do
      fill_in "Search term", with: "strawberry hats"
      click_button "Search"
    end
    page.should have_css(".auction a", text: "strawberry hats")

    within "#auction_search_sidebar" do
      fill_in "Search term", with: "cherry"
      click_button "Search"
    end
    page.should have_css(".auction a", text: "banana colored shoes")

    within "#auction_search_sidebar" do
      fill_in "Search term", with: "other"
      click_button "Search"
    end
    page.should have_css(".auction a", text: "strawberry hats")

    within "#auction_search_sidebar" do
      fill_in "Search term", with: "erin"
      click_button "Search"
    end
    page.should have_css(".auction a", text: "banana colored shoes")
  end
end
