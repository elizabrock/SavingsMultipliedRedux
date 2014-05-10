class ClothingType < ActiveRecord::Base
  SAMPLE_TYPES = ["Tops", "Bottoms", "Onesies", "Outerwear", "Dresses", "Shoes"]

  validates_presence_of :name
end
