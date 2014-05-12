require 'spec_helper'

feature "User Edits Profile" do
  # In order to control the information that is displayed about me
  # As a logged in user
  # I want to edit my profile

  # - Includes ability to modify name, email, password, number/gender of children, upload a profile image, bio

  before do
    login_as :user, first_name: "Sally", last_name: "Hansen"
    Fabricate(:relationship_to_children, name: "Mother")
    Fabricate(:child_configuration, genders: "mmm", siblings_type: "triplets")
    click_link "Sally H."
  end
  scenario "initial profile shouldn't include bio" do
    page.should_not have_content("Bio")
  end
  scenario "happy path, without changing password" do
    click_link "Edit My Profile"
    fill_in "First name", with: "Ally"
    fill_in "Last name", with: "McMarried"
    fill_in "Bio", with: "I just got married and had triplets!"
    select "Mother", from: "I am the"
    select "triplets - mmm", from: "darling children"
    fill_in "Email", with: "ally@mcmarried.example.com"
    fill_in "Current Password", with: "myawfulpassword"
    click_button "Update My Profile"
    page.should have_content "Your profile has been updated."
    click_link "Ally M."
    page.should have_content "Ally M."
    page.should have_content "I just got married and had triplets!"
    page.should have_content "Mother"
    page.should have_content "3 darling children"
    all(".child_icons .m").count.should == 3

    click_link "Edit My Profile"
    page.body.should include "McMarried"
    page.body.should include "ally@mcmarried.example.com"
  end
  scenario "happy path, with photo upload" do
    click_link "Edit My Profile"
    attach_file "Profile Image", "spec/support/files/ally.jpg"
    fill_in "Current Password", with: "myawfulpassword"
    click_button "Update My Profile"
    page.should have_content "Your profile has been updated."
    click_link "Sally H."
    find("img.profile")["src"].should include("ally.jpg")
  end
  scenario "happy path, changing password" do
    click_link "Edit My Profile"
    fill_in "First name", with: "Ally"
    fill_in "Last name", with: "McMarried"
    fill_in "Email", with: "ally@mcmarried.example.com"
    fill_in "Password", with: "aBetterPassw0rd"
    fill_in "Password Confirmation", with: "aBetterPassw0rd"
    fill_in "Current Password", with: "myawfulpassword"
    click_button "Update My Profile"
    page.should have_content "Your profile has been updated."
    page.should have_content "Ally M."

    click_link "sign out"
    fill_in "Email", with: "ally@mcmarried.example.com"
    fill_in "Password", with: "aBetterPassw0rd"
    click_button "Sign in"
    page.should have_content("Signed in successfully.")
  end
  scenario "trying to change password with an invalid password" do
    click_link "Edit My Profile"
    fill_in "Password", with: "aBetterPassw0rd"
    fill_in "Password Confirmation", with: "aBetterPassw0rd"
    fill_in "Current Password", with: "notmypassword"
    click_button "Update My Profile"
    page.should have_content "Current Passwordis invalid"

    click_link "sign out"
    fill_in "Email", with: "ally@mcmarried.example.com"
    fill_in "Password", with: "aBetterPassw0rd"
    click_button "Sign in"
    page.should have_content("Invalid email or password.")
  end
  scenario "edit link isn't shown on others' profiles" do
    other_user = Fabricate(:user, first_name: "Bob")
    visit user_path(other_user)
    page.should have_no_content("Edit My Profile")
  end
end
