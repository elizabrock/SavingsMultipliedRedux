ActiveAdmin.register Brand do
  actions :all, :except => [:destroy]

  permit_params :name
end
