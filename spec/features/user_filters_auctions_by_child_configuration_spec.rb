require 'spec_helper'

feature "User filters current auctions" do
  # In order to browse auctions that are appropriate to my situation
  # As a signed out user
  # I want to narrow the view of current auctions to auctions for my type of
  # children

  # - While browsing, the user is prompted to limit their search to twins/triplets/quads/sibling sets
  # - Once the 2/3/4 selection has been made, they are prompted to select the gender if applicable (e.g. b/b/g/g)

  background do
    twins_bg = Fabricate(:child_configuration, siblings_type: "twins", genders: "bg")
    twins_gg = Fabricate(:child_configuration, siblings_type: "twins", genders: "gg")
    triplets_bbb = Fabricate(:child_configuration, siblings_type: "triplets", genders: "bbb")
    siblings_bg = Fabricate(:child_configuration, siblings_type: "sibling sets", genders: "bg")
    quads_gbbb = Fabricate(:child_configuration, siblings_type: "quads", genders: "gbbb")

    Fabricate(:active_auction, title: "bg twin clothes", child_configurations: [twins_bg, siblings_bg])
    Fabricate(:active_auction, title: "bg sibling clothes", child_configurations: [siblings_bg])
    Fabricate(:closed_auction, title: "closed bg twin clothes", child_configurations: [twins_bg])
    Fabricate(:active_auction, title: "gg twin clothes", child_configurations: [twins_gg])
    Fabricate(:active_auction, title: "bbb triplet clothes", child_configurations: [triplets_bbb])
    Fabricate(:active_auction, title: "gbbb triplet clothes", child_configurations: [quads_gbbb])
  end

  scenario "limiting auction results to a particular child configuration" do
    visit '/'
    click_link "Buy"
    page.should have_link "sibling sets"
    page.should have_link "twins"
    page.should have_link "triplets"
    page.should have_link "quads"
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"

    click_link "twins"
    within ".breadcrumb_navigation" do
      page.should have_content "twins"
    end
    page.should have_link "bg"
    page.should have_link "gg"
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should_not have_content "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"

    click_link "bg"
    within ".breadcrumb_navigation" do
      page.should have_content "twins"
      page.should have_css ".child_icons.bg"
    end
    page.should have_link "bg twin clothes"
    page.should_not have_content "gg twin clothes"
    page.should_not have_content "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"

    visit current_url # reloads the current url, to verify that the path reflects the selections
    within ".breadcrumb_navigation" do
      page.should have_content "twins"
      page.should have_css ".child_icons.bg"
    end
    page.should have_link "bg twin clothes"
    page.should_not have_content "gg twin clothes"
    page.should_not have_content "bbb triplet clothes"
    page.should_not have_content "closed bg twin clothes"
  end

  scenario "breadcrumb navigation allows navigation back to 'All'" do
    visit '/'
    click_link "Buy"
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"

    click_link "triplets"
    page.should_not have_link "bg twin clothes"
    page.should_not have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"

    click_link 'All'
    page.should have_link "sibling sets"
    page.should have_link "twins"
    page.should have_link "triplets"
    page.should have_link "quads"
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"
  end

  scenario "breadcrumb navigation allows navigation back to the siblings type" do
    visit '/'
    click_link "Buy"
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should have_link "bbb triplet clothes"

    click_link "twins"
    click_link "gg"
    page.should_not have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should_not have_link "bbb triplet clothes"

    click_link 'twins'
    page.should have_link "bg twin clothes"
    page.should have_link "gg twin clothes"
    page.should_not have_link "bbb triplet clothes"
  end
end
