require 'spec_helper'

describe ClothingType do
  it { should validate_presence_of :name }
end
