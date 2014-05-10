class Season < ActiveRecord::Base
  POSSIBLE_SEASONS = %w{spring summer autumn winter}

  validates_presence_of :name
end
