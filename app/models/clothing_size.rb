class ClothingSize < ActiveRecord::Base
  POSSIBLE_SIZES = ["Newborn", "3 months", "6 months", "9 months", "12 months", "18 months", "24 months", "2T", "3T", "4T", "5T"]

  validates_presence_of :name
end
