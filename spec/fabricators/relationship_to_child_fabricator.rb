Fabricator(:relationship_to_children) do
  name { sequence(:name) { |i| "Auntie#{i}" } }
end
