Fabricator(:auction) do
  brand
  clothing_condition
  clothing_type
  description "a grand, grand auction"
  item_photo { File.open(File.join(Rails.root, 'spec', 'support', 'files', 'ally.jpg')) }
  title "an auction"
  user
  starting_price 12
  clothing_sizes { [ClothingSize.first || Fabricate(:clothing_size)] }
  child_configurations { [ChildConfiguration.first || Fabricate(:child_configuration)] }
end

Fabricator(:active_auction, from: :auction) do
  ends_at { 3.days.from_now }
end

Fabricator(:closed_auction, from: :auction) do
  ends_at { 5.days.ago }
end
