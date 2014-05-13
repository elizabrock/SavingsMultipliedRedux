require 'collection_size_validator'

class Auction < ActiveRecord::Base

  belongs_to :brand
  belongs_to :clothing_condition
  belongs_to :clothing_type
  belongs_to :season
  belongs_to :user

  has_many :auction_child_configurations
  has_many :auction_clothing_sizes
  has_many :clothing_sizes, through: :auction_clothing_sizes
  has_many :child_configurations, through: :auction_child_configurations

  mount_uploader :item_photo, ProfileImageUploader

  validates_presence_of :brand, :clothing_condition, :clothing_type, :description, :item_photo, :title, :user
  validates_numericality_of :starting_price, greater_than: 0
  validates :clothing_size_ids, :child_configuration_ids, :collection_size => { :minimum => 1 }

  before_create :set_ends_at

  scope :active, ->{ where("ends_at > ?", Time.now) }
  scope :search_by, ->(term){ where("title like ?", "%#{term}%") }

  private

  def set_ends_at
    self.ends_at ||= 10.days.from_now
  end
end
