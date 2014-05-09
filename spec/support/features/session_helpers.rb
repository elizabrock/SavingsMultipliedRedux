module Features
  module SessionHelpers
    def login_as(user_type)
      user = Fabricate(user_type)
      visit admin_root_path
      fill_in 'Email*', with: user.email
      fill_in 'Password*', with: "myawfulpassword"
      click_button 'Login'
      page.should have_content("Signed in successfully.")
    end
  end
end
