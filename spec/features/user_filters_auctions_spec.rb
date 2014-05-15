require 'spec_helper'

feature "User filters current auctions" do
  # In order to see only items appropriate for my current needs
  # As a logged in or logged out user
  # I want to limit my searching/browsing to certain criteria

  # includes options to limit by:
  # - search term
  # - condition
  # - size (only sizes we have items for are shown, displayed in numerical order with baby sizes first)
  # - season
  # - type (pants, tops, etc.)
  # - brand (alphabetical order)
  # The page URL reflects the current view (e.g. it's linkable)


  # - While browsing, the user is prompted to limit their search to twins/triplets/quads/sibling sets
  # - Once the 2/3/4 selection has been made, they are prompted to select the gender if applicable (e.g. b/b/g/g)
  background do
    Fabricate(:child_configuration, siblings_type: "quads", genders: "ffff")
    janie_and_jack = Fabricate(:brand, name: "Janie & Jack")
    baby_gap = Fabricate(:brand, name: "Baby GAP")
    other_brand = Fabricate(:brand, name: "other")
    size_3T = Fabricate(:clothing_size, name: "3T")
    size_2T = Fabricate(:clothing_size, name: "2T")
    size_2M = Fabricate(:clothing_size, name: "2M")
    new = Fabricate(:clothing_condition, name: "new")
    gently_used = Fabricate(:clothing_condition, name: "gently used")
    pants = Fabricate(:clothing_type, name: "pants")
    outerwear = Fabricate(:clothing_type, name: "outerwear")
    tops = Fabricate(:clothing_type, name: "tops")
    spring = Fabricate(:season, name: "spring")
    summer = Fabricate(:season, name: "summer")
    fall = Fabricate(:season, name: "fall")
    winter = Fabricate(:season, name: "winter")
    Fabricate(:auction, title: "a", clothing_condition: new, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: pants, season: spring)
    Fabricate(:auction, title: "b", clothing_condition: new, clothing_sizes: [size_3T], brand: janie_and_jack, clothing_type: pants, season: spring)
    Fabricate(:auction, title: "c", clothing_condition: gently_used, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: tops, season: fall)
    Fabricate(:auction, title: "d", clothing_condition: gently_used, clothing_sizes: [size_3T], brand: other_brand, clothing_type: tops, season: fall)
    Fabricate(:auction, title: "e", clothing_condition: new, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: outerwear, season: winter)
    Fabricate(:auction, title: "f", clothing_condition: gently_used, clothing_sizes: [size_2M], brand: other_brand, clothing_type: outerwear, season: fall)
    Fabricate(:auction, title: "g", clothing_condition: new, clothing_sizes: [size_2T], brand: janie_and_jack, clothing_type: outerwear, season: summer)
  end

  scenario "no results" do
    all_auctions =  %w{a b c d e f g}
    visit '/'
    within "header" do
      fill_in "Search term", with: "notgoingtohaveresults"
    end
    click_button "Search"
    page.should have_no_auction_results(all_auctions)
    page.should have_content "No auctions found"
  end

  def self.assert_search_results_from(summary, expected_auction_list, &block)
    scenario "limit by #{summary }" do
      all_auctions =  %w{a b c d e f g}
      visit '/'
      click_link "Buy"
      click_link "quads"
      click_link "ffff"
      # ^-- the auctions are built for the ffff quads child_configuration
      # we first created above.

      page.should have_auction_results(all_auctions)

      block.call(page)
      within "#auction_search_sidebar" do
        click_button "Search"
      end

      page.should have_auction_results(expected_auction_list)
      page.should have_no_auction_results(all_auctions - expected_auction_list)

      visit current_url # reloads the current url, to verify that the path reflects the selections
      page.should have_auction_results(expected_auction_list)
      page.should have_no_auction_results(all_auctions - expected_auction_list)
    end
  end

  assert_search_results_from("new", %w{ a b e g }) do |page|
    page.select "new"
  end

  assert_search_results_from("used", %w{ c d f }) do |page|
    page.select "gently used"
  end

  assert_search_results_from("new and 2T", %w{ a e g }) do |page|
    page.select "new"
    page.check "2T"
  end

  assert_search_results_from("Baby GAP", %w{ a c e }) do |page|
    page.check "Baby GAP"
  end

  assert_search_results_from("Baby GAP and Jack & Janie", %w{ a b c e g }) do |page|
    page.check "Baby GAP"
    page.check "Janie & Jack"
  end

  assert_search_results_from("2T", %w{ a c e g }) do |page|
    page.check "2T"
  end

  assert_search_results_from("2T and 3T", %w{ a b c d e g }) do |page|
    page.check "2T"
    page.check "3T"
  end

  assert_search_results_from("outerwear", %w{ e f g }) do |page|
    page.check "outerwear"
  end

  assert_search_results_from("outerwear and tops", %w{ c d e f g }) do |page|
    page.check "outerwear"
    page.check "tops"
  end

  assert_search_results_from("spring", %w{ a b }) do |page|
    page.check "spring"
  end

  assert_search_results_from("summer", %w{ a b g }) do |page|
    page.check "spring"
    page.check "summer"
  end

  assert_search_results_from("outerwear", %w{ e g }) do |page|
    page.check "2T"
    page.check "outerwear"
  end
end
