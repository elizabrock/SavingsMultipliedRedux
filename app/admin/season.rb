ActiveAdmin.register Season do
  actions :all, :except => [:destroy]

  permit_params :name
end
