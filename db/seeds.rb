# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


RelationshipToChildren::DEFAULT_RELATIONSHIPS.each do |relationship_name|
  RelationshipToChildren.find_or_create_by(name: relationship_name)
end

ChildConfiguration::POSSIBLE_CONFIGURATIONS.each do |pair|
  type = pair[0].to_s
  configurations = pair[1]
  configurations.each do |configuration|
    unless ChildConfiguration.find_by(siblings_type: type, genders: configuration) then
      ChildConfiguration.create( :siblings_type => type,
                                 :genders => configuration)
    end
  end
end

ClothingCondition::POSSIBLE_CONDITIONS.each_with_index do |name, i|
  unless ClothingCondition.find_by_name(name) then
    ClothingCondition.create( :name => name)
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

ChildConfiguration.all.each do |child_configuration|
  listing = Fabricate(:auction,
                  :title => "#{child_configuration.name} listing",
                  :description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec quis quam quis erat adipiscing molestie. Aliquam non ante justo. Phasellus feugiat nulla nec ante mattis viverra. Quisque tristique elementum tempor. Quisque accumsan odio a leo sagittis nec cursus lorem tempus. Aliquam ut nisi eu odio molestie pulvinar in ut dolor. Sed imperdiet malesuada neque volutpat consequat. Nulla scelerisque venenatis nisi vel placerat. Aliquam augue orci, placerat in cursus sit amet, dapibus vel neque. Quisque hendrerit mattis metus et ultricies. ",
                  :starting_price => "10.00",
                  :clothing_condition => ClothingCondition.all.sample,
                  :child_configurations => [child_configuration],
                  :clothing_type => ClothingType.all.sample,
                  :brand => Brand.all.sample,
                  :user => (User.first || Fabricate(:user, :relationship_to_children => RelationshipToChildren.all.sample)),
                  :season => Season.all.sample,
                  :clothing_sizes => [ClothingSize.all.sample]
                  )
end
