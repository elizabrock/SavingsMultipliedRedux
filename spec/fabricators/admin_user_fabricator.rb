Fabricator(:admin_user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password "myawfulpassword"
  password_confirmation "myawfulpassword"
end
