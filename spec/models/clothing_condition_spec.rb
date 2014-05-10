require 'spec_helper'

describe ClothingCondition do
  it { should validate_presence_of :name }
end
