require 'spec_helper'

describe RelationshipToChildren do
  before do
    Fabricate(:relationship_to_children)
  end
  it { should validate_uniqueness_of(:name) }
end
