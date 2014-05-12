require 'spec_helper'

feature "user signs up" do
  # In order to place bids or list auctions
  # As a guest
  # I want to sign up

  background do
    Fabricate(:relationship_to_children, name: "mother")
    Fabricate(:relationship_to_children, name: "aunt")
    Fabricate(:page, title: "Terms and Conditions", slug: "termsandconditions", content: "The terms are nice")
    Fabricate(:child_configuration, siblings_type: "siblings", genders: "mf")
    Fabricate(:child_configuration, siblings_type: "triplets", genders: "mff")
  end
  scenario "Happy Path Registration" do
    visit "/"
    click_link "sign up"
    fill_in "First name", with: "Eliza"
    fill_in "Last name", with: "Brock"
    fill_in "Email", with: "eliza@example.com"
    check "This is the email I use with PayPal"
    # e.g. I am the aunt of 2 darling children
    select "aunt", from: "I am the"
    select "triplets - mff", from: "darling children"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    #e.g. I check "I accept the terms and conditions"
    check "I accept the terms and conditions"
    click_button "Sign up"
    page.should have_content "You are now signed up for Savings Multiplied!"
    page.should have_content "You are signed in as Eliza B."

    click_link "Eliza B."
    page.should have_css("h1,h2,h3", text: "Eliza B.")
    page.should have_content "aunt"
    all(".child_icons .m").should be
    all(".child_icons .f").count.should == 2
  end

  scenario "Registration errors" do
    visit "/"
    click_link "sign up"
    click_button "Sign up"
    page.should have_content("First namecan't be blank")
    page.should have_content("Last namecan't be blank")
    page.should have_content("Emailcan't be blank")
    page.should have_content("darling childrensiblings - mftriplets - mffcan't be blank")
    page.should have_content("I accept the terms and conditionsmust be accepted")

    fill_in "Email", with: "eliza@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"
    page.should have_content("must be the email you use with PayPal")
    page.should have_content("Password confirmationdoesn't match Password")
  end

  scenario "viewing the terms and conditions" do
    visit "/"
    click_link "sign up"
    click_link "terms and conditions"
    page.should have_content("The terms are nice")
  end
end
