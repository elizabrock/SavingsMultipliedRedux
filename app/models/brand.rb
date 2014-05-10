class Brand < ActiveRecord::Base
  SAMPLE_BRANDS = ["Baby Gap", "Janie & Jack", "Carter's", "Old Navy", "Pottery Barn Kids", "Crew Cuts", "Etsy/Handmade"]

  validates_presence_of :name
end
