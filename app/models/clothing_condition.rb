class ClothingCondition < ActiveRecord::Base
  POSSIBLE_CONDITIONS = ["new", "gently used"]

  validates_presence_of :name
end
