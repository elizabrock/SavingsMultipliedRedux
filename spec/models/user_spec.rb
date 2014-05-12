require 'spec_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:relationship_to_children_id) }
    it { should validate_presence_of(:child_configuration_id) }
    it { should validate_acceptance_of(:terms_accepted) }
    it { should validate_acceptance_of(:email_is_used_with_paypal).with_message("must be the email you use with PayPal") }
    it { should have_many :auctions }
  end
end
