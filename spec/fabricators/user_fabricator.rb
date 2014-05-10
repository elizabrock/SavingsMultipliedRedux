Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password "myawfulpassword"
  password_confirmation "myawfulpassword"
  terms_accepted true
  email_is_used_with_paypal true
  first_name "Joe"
  last_name "Johnson"
  child_configuration
  relationship_to_children
end
