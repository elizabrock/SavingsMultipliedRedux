ActiveAdmin.register ClothingSize do
  actions :all, :except => [:destroy]

  permit_params :name
end
