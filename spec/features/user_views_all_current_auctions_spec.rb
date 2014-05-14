require 'spec_helper'

feature "User views all current auctions" do
  # In order to get an overview of the available auctions
  # As a logged in or logged out user
  # I want to view all the current auctions

  # - only shows current auctions
  # - The page URL reflects the selections (e.g. it's linkable)
  before do
    bg_twins = Fabricate(:child_configuration, siblings_type: "twins", genders: "bg")
    gg_twins = Fabricate(:child_configuration, siblings_type: "twins", genders: "gg")
    bbb_triplets = Fabricate(:child_configuration, siblings_type: "triplets", genders: "bbb")

    Fabricate(:active_auction, child_configurations: [bg_twins], title: "bg twin clothes", description: "best")
    Fabricate(:closed_auction, child_configurations: [bg_twins], title: "closed bg twin clothes", description: "best")
    Fabricate(:active_auction, child_configurations: [gg_twins], title: "gg twin clothes", description: "best")
    Fabricate(:active_auction, child_configurations: [bbb_triplets], title: "bbb triplet clothes", description: "best")
    Fabricate(:active_auction, child_configurations: [bg_twins], title: "banana colored shoes", description: "cherry laces")
    Fabricate(:active_auction, child_configurations: [bg_twins], title: "strawberry hats", description: "best")
  end

  def test_index
    visit '/'
    click_link "Buy"
    page.should have_css(".breadcrumb_navigation a", text: "All")
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"

    visit current_path # reloads the current url, to verify that the path reflects the selections
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"
  end

  scenario "auctions page shows all current auctions to guests" do
    test_index
  end

  scenario "auctions page shows all current auctions to guests" do
    login_as :user
    test_index
  end
end
