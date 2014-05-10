ActiveAdmin.register ClothingType do
  actions :all, :except => [:destroy]

  permit_params :name
end
