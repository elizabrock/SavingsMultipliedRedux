require 'spec_helper'

feature "Admin manages site pages" do
  # In order to control the site content
  # As an admin
  # I want to create and edit the non-dynamic site pages
  #
  # editable fields are: title, Slug, page content
  # url will be in the format of: savingsmultiplied.com/pages/<pageslug>
  # e.g. savingsmultiplied.com/pages/about
  # page content will be in markdown format
  scenario "create and view a new site page" do
    login_as(:admin_user)
    click_link 'Pages'
    click_link 'New Page'
    fill_in "Title", with: "Member Discounts"
    fill_in "Slug", with: "discounts"
    fill_in "Content", with: "this is my page with a [an example link](http://example.com)"
    click_button 'Create Page'
    page.should have_content "Page was successfully created."

    visit '/pages/discounts'
    page.title.should == "Member Discounts on Savings Multiplied"
    page.should have_css("h1, h2, h3", "Member Discounts")
    page.should have_content("this is my page")
    page.should have_css("a[href='http://example.com']", text: "an example link")
  end
  scenario "deleting a page", js: true do
    login_as(:admin_user)
    Fabricate(:page, slug: "special-today-only", title: "Yesterday's Specials")
    click_link 'Pages'
    link = page.find('tr', text: "Yesterday's Specials").find("a", text: "View")
    link.click
    click_link "Delete Page"
    page.should have_content("Page was successfully destroyed.")

    visit '/pages/special-today-only'
    page.should have_content("The page could not be found.")
  end
end
