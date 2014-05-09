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
