ActiveAdmin.register ClothingCondition do
  actions :all, :except => [:destroy]

  permit_params :name
end
