# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


RelationshipToChildren::POSSIBLE_RELATIONSHIPS.each do |relationship_name|
  RelationshipToChildren.find_or_create_by_name(relationship_name)
end

ChildConfiguration::POSSIBLE_CONFIGURATIONS.each do |pair|
  type = pair[0].to_s
  configurations = pair[1]
  configurations.each do |configuration|
    unless ChildConfiguration.find_by_siblings_type_and_genders(type, configuration) then
      ChildConfiguration.create( :display_position => display_order,
                                 :siblings_type => type,
                                 :genders => configuration)
    end
  end
end

ItemCondition::POSSIBLE_CONDITIONS.each_with_index do |name, i|
  unless ItemCondition.find_by_name(name) then
    ItemCondition.create( :name => name)
  end
end

Season::POSSIBLE_SEASONS.each_with_index do |name, i|
  unless Season.find_by_name(name) then
    Season.create!(:name => name)
  end
end

ClothingSize::POSSIBLE_SIZES.each_with_index do |name, i|
  unless ClothingSize.find_by_name(name) then
    ClothingSize.create!(:name => name)
  end
end

Brand::SAMPLE_BRANDS.each_with_index do |name, i|
  unless Brand.find_by_name(name) then
    Brand.create!(:name => name)
  end
end

ClothingType::SAMPLE_TYPES.each_with_index do |name, i|
  unless ClothingType.find_by_name(name) then
    ClothingType.create!(:name => name)
  end
end
