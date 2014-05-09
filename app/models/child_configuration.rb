class ChildConfiguration < ActiveRecord::Base
  POSSIBLE_CONFIGURATIONS = {
    :siblings => %w{mm ff mf},
    :twins => %w{mm ff mf},
    :triplets => %w{mmm mmf mff fff},
    :quads => %w{mmmm mmmf mmff mfff ffff}
  }

  validates_presence_of :genders, :siblings_type

  def name
    "#{siblings_type} - #{genders}"
  end

  def number_of_children
    genders.size
  end

  def female_child_count
    genders.count('f')
  end

  def male_child_count
    genders.count('m')
  end
end

