require 'spec_helper'

feature "User sorts current auctions" do
  # In order to find cheap/expensive/similar auctions
  # As a person browsing the site
  # I want to sort the auctions

  # - Sortable by current bid, title, time-until-expiration
  # - Default sort is time-until-expiration with auctions ending soonest being shown first
  # - Sorting does not change any of the current browsing criteria (e.g. size/type/brand/etc.)
  # - The page URL reflects the current view (e.g. it's linkable)

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
    Fabricate(:auction, title: "d", clothing_condition: gently_used, clothing_sizes: [size_3T], brand: other_brand, clothing_type: tops, season: fall)
    Fabricate(:auction, title: "e", clothing_condition: new, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: outerwear, season: winter)
    Fabricate(:auction, title: "f", clothing_condition: gently_used, clothing_sizes: [size_2M], brand: other_brand, clothing_type: outerwear, season: fall)
    Fabricate(:auction, title: "g", clothing_condition: new, clothing_sizes: [size_2T], brand: janie_and_jack, clothing_type: outerwear, season: summer)
    Fabricate(:auction, title: "a", clothing_condition: new, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: pants, season: spring)
    Fabricate(:auction, title: "b", clothing_condition: new, clothing_sizes: [size_3T], brand: janie_and_jack, clothing_type: pants, season: spring)
    Fabricate(:auction, title: "c", clothing_condition: gently_used, clothing_sizes: [size_2T], brand: baby_gap, clothing_type: tops, season: fall)
  end

  def all_auctions
    %w{a b c d e f g}
  end

  scenario "sorting all auctions by time left" do
    visit '/'
    click_link "Buy"
    click_link "quads"
    click_link "ffff"

    time_left_order = %w{d e f g a b c}

    select "Time Left"
    click_button "Sort"
    page.should have_sorted_auction_results(all_auctions, order: time_left_order)

    visit current_url # reloads the current url, to verify that the path reflects the selections
    page.should have_sorted_auction_results(all_auctions, order: time_left_order)
  end

  scenario "sorting all auctions by title" do
    visit '/'
    click_link "Buy"
    click_link "quads"
    click_link "ffff"

    title_order = %w{a b c d e f g}

    select "Title"
    click_button "Sort"
    page.should have_sorted_auction_results(all_auctions, order: title_order)

    visit current_url # reloads the current url, to verify that the path reflects the selections
    page.should have_sorted_auction_results(all_auctions, order: title_order)
  end

  scenario "sorting all auctions by price" do
    pending "the ability to bid"
    visit '/'
    click_link "Buy"
    click_link "quads"
    click_link "ffff"

    price_order = %w{e d c f a b g}

    select "Price"
    click_button "Sort"
    page.should have_sorted_auction_results(all_auctions, order: price_order)

    visit current_url # reloads the current url, to verify that the path reflects the selections
    page.should have_sorted_auction_results(all_auctions, order: price_order)
  end

  def self.assert_search_results_from(summary, expected_auction_list, &block)
    scenario "limit by #{summary }" do
      visit '/'
      click_link "Buy"
      click_link "quads"
      click_link "ffff"
      # ^-- the auctions are built for the ffff quads child_configuration
      # we first created above.

      block.call(page)
      within "#auction_search_sidebar" do
        click_button "Search"
      end

      time_left_order = %w{d e f g a b c}
      title_order = %w{a b c d e f g}
      price_order = %w{e d c f a b g}

      page.should have_sorted_auction_results(expected_auction_list, order: time_left_order )
      visit current_url # reloads the current url, to verify that the path reflects the selections
      page.should have_sorted_auction_results(expected_auction_list, order: time_left_order )

      select "Title"
      click_button "Sort"
      order = %w{a b c d e f g}
      page.should have_sorted_auction_results(expected_auction_list, order: title_order )
      visit current_url # reloads the current url, to verify that the path reflects the selections
      page.should have_sorted_auction_results(expected_auction_list, order: title_order )

      select "Time Left"
      click_button "Sort"
      page.should have_sorted_auction_results(expected_auction_list, order: time_left_order)
      visit current_url # reloads the current url, to verify that the path reflects the selections
      page.should have_sorted_auction_results(expected_auction_list, order: time_left_order)

      pending "ability to place bids"
      select "Price"
      click_button "Sort"
      page.should have_sorted_auction_results(expected_auction_list, order: price_order)
      visit current_url # reloads the current url, to verify that the path reflects the selections
      page.should have_sorted_auction_results(expected_auction_list, order: price_order)
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
