class RelationshipToChildren < ActiveRecord::Base
  validates_uniqueness_of :name

  DEFAULT_RELATIONSHIPS = ["mother", "father", "aunt", "uncle", "grandma", "grandpa", "sister", "brother"]
end

