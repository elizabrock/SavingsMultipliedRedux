require 'spec_helper'

feature "User lists an auction" do
  # In order to sell my items
  # As a logged in user
  # I want to list an auction

  # - user enters item condition, size(s), season(s), type (e.g. pants), brand, number/gender of items, item title, item description, starting bid price, and buy now price
  # - user can upload one item photo

  before do
    Fabricate(:child_configuration, siblings_type: "triplets", genders: "mmm")
    Fabricate(:child_configuration, siblings_type: "triplets", genders: "mmf")
    Fabricate(:child_configuration, siblings_type: "siblings", genders: "mf")
    Fabricate(:clothing_condition, name: "new")
    Fabricate(:clothing_condition, name: "gently used")
    Fabricate(:season, name: "Spring")
    Fabricate(:season, name: "Summer")
    Fabricate(:clothing_size, name: "3T")
    Fabricate(:clothing_size, name: "5")
    Fabricate(:clothing_type, name: "jackets")
    Fabricate(:clothing_type, name: "full outfits")
    Fabricate(:brand, name: "Janie & Jack")
  end

  scenario "A signed out user is redirect upon logging in" do
    visit root_path
    click_link "Sell"
    page.should have_content "You need to sign in or sign up before continuing."
    login_as :user
    current_path.should == new_auction_path
  end

  scenario "happy path auction creation" do
    user = login_as :user, first_name: "Sue", last_name: "Smith"
    click_link "Sell"
    fill_in "Title", with: "3 boys sailor suits"
    fill_in "Starting Price", with: "48.00"
    check "triplets - mmm"
    select "new", from: "Condition"
    select "Spring"
    check "3T"
    select "Janie & Jack", from: "Brand"
    select "full outfits", from: "Clothing Type"
    fill_in "Description", with: "Three Brand New Janie & Jack boys sailor suits in size 3T"
    attach_file "Item Photo", "spec/support/files/ally.jpg"
    # click_button "Preview my auction"
    click_button "START AUCTION"
    within(".auction") do
      page.should have_content("3 boys sailor suits")
      find("img.item_photo")["src"].should include("ally.jpg")
      page.should have_content "new"
      page.should have_content "Spring"
      page.should have_content "3T"
      page.should have_content "Janie & Jack"
      page.should have_content "Three Brand New Janie & Jack boys sailor suits in size 3T"
      page.should have_content "Sue S."
      click_link "Sue S."
    end
    current_path.should == user_path(user)
    page.should have_content("Sue's Current Listings")
    page.should have_content("3 boys sailor suits")
    click_link "3 boys sailor suits"
    current_path.should == auction_path(Auction.last)
  end

  scenario "missing auction values" do
    user = login_as :user, first_name: "Sue", last_name: "Smith"
    click_link "Sell"
    # click_button "Preview my auction"
    click_button "START AUCTION"
    page.should have_error("can't be blank", on: "Title")
    page.should have_error("must be greater than 0", on: "Starting Price")
    page.should have_error("can't be blank", on: "Condition")
    page.should have_error("can't be blank", on: "Brand")
    page.should have_error("can't be blank", on: "Clothing Type")
    page.should have_error("can't be blank", on: "Description")
    page.should have_error("can't be blank", on: "Season")
    page.should have_error("can't be blank", on: "Item Photo")
    page.should have_collection_error("must select at least 1", on: "auction_child_configurations")
    page.should have_collection_error("must select at least 1", on: "auction_clothing_sizes")
  end

  scenario "creating a auction with multiple sizes, set types and seasons" do
    user = login_as :user, first_name: "Sue", last_name: "Smith"
    click_link "Sell"
    fill_in "Title", with: "sibling sailor suits"
    fill_in "Starting Price", with: "48"
    check "siblings - mf"
    check "triplets - mmm"
    select "gently used", from: "Condition"
    select "Summer"
    check "3T"
    check "5"
    select "Janie & Jack", from: "Brand"
    select "full outfits", from: "Clothing Type"
    fill_in "Description", with: "Brand New Janie & Jack sailor suits in size 3T and 5.  They fit my kids when they were 3 years old and 6 years old perfectly."
    attach_file "Item Photo", "spec/support/files/ally.jpg"
    # click_button "Preview my auction"
    click_button "START AUCTION"
    auction = Auction.last
    page.should have_content("Your auction has been created.")
    current_path.should == auction_path(auction)
    within(".auction") do
      find("img.item_photo")["src"].should include("ally.jpg")
      page.should have_content "gently used"
      page.should have_content "Summer"
      page.should have_content "3T"
      page.should have_content "5"
      page.should have_css(".mmm")
      page.should have_css(".mf")
    end
  end
end
