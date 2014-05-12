class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_image, ProfileImageUploader

  validates_acceptance_of :terms_accepted, allow_nil: false, accept: true
  validates_acceptance_of :email_is_used_with_paypal, allow_nil: false, accept: true, :message => "must be the email you use with PayPal"
  validates_presence_of :first_name, :last_name, :relationship_to_children_id, :child_configuration_id


  belongs_to :relationship_to_children
  belongs_to :child_configuration
  has_many :auctions

  def full_name
    "#{first_name} #{last_name[0,1]}."
  end
end
