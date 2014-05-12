module Features
  module SessionHelpers
    def login_as(user_type, options = {})
      user = Fabricate(user_type, options)
      if user.is_a? AdminUser
        visit admin_root_path
        fill_in 'Email*', with: user.email
        fill_in 'Password*', with: "myawfulpassword"
        click_button 'Login'
      else
        visit new_user_session_path unless current_path == new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: "myawfulpassword"
        click_button 'Sign in'
      end
      page.should have_content("Signed in successfully.")
      user
    end
  end
end
