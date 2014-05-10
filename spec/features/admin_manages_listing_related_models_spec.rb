require 'spec_helper'

feature "Admin administers clothing types, brand names, and clothing sizes" do
  # These tests are a sanity check to make sure that this functionality is
  # enabled in ActiveAdmin.  It isn't exhaustive because we can assume that if
  # the basic functionality is hooked up that the rest of it is likely working
  # correctly.

  scenario "create and view a new clothing type" do
    login_as(:admin_user)
    click_link 'Clothing Types'
    click_link 'New Clothing Type'
    fill_in "Name", with: "Zoot Suits"
    click_button 'Create Clothing type'
    page.should have_content "Clothing type was successfully created."

    page.should have_css("table td", text: "Zoot Suits")
    page.should_not have_content("Delete")
  end
  scenario "create and view a new brand" do
    login_as(:admin_user)
    click_link 'Brands'
    click_link 'New Brand'
    fill_in "Name", with: "GAP Baby"
    click_button 'Create Brand'
    page.should have_content "Brand was successfully created."

    page.should have_css("table td", text: "GAP Baby")
    page.should_not have_content("Delete")
  end

  scenario "create and view a new clothing size" do
    login_as(:admin_user)
    click_link 'Clothing Sizes'
    click_link 'New Clothing Size'
    fill_in "Name", with: "Newborn"
    click_button 'Create Clothing size'
    page.should have_content "Clothing size was successfully created."

    page.should have_css("table td", text: "Newborn")
    page.should_not have_content("Delete")
  end

  scenario "create and view a new clothing condition" do
    login_as(:admin_user)
    click_link 'Clothing Conditions'
    click_link 'New Clothing Condition'
    fill_in "Name", with: "Old and Grody"
    click_button 'Create Clothing condition'
    page.should have_content "Clothing condition was successfully created."

    page.should have_css("table td", text: "Old and Grody")
    page.should_not have_content("Delete")
  end
end
