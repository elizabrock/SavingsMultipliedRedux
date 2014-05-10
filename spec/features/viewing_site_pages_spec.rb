require 'spec_helper'

feature "Users view site pages" do
  let(:page_url){ '/pages/hello_world' }
  background do
    Fabricate(:page, slug: 'hello_world', content: "Isn't life grand")
  end
  scenario "viewing a page that exists, as an admin" do
    login_as(:admin_user)
    visit page_url
    page.should have_content("Isn't life grand")
  end
  scenario "viewing a page that exists, as a regular user" do
    login_as(:user)
    visit page_url
    page.should have_content("Isn't life grand")
  end
  scenario "viewing a page that exists, as a guest" do
    visit page_url
    page.should have_content("Isn't life grand")
  end
  scenario "viewing a page that does not exist, as an admin" do
    login_as(:admin_user)
    visit '/pages/no_world'
    page.should have_content("The page could not be found.")
  end
  scenario "viewing a page that does not exist, as a regular user" do
    login_as(:user)
    visit '/pages/no_world'
    page.should have_content("The page could not be found.")
  end
  scenario "viewing a page that does not exist, as a guest" do
    visit '/pages/no_world'
    page.should have_content("The page could not be found.")
  end
end
