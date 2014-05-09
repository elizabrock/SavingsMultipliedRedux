require 'spec_helper'

describe ChildConfiguration do
  it { should validate_presence_of :siblings_type }
  it { should validate_presence_of :genders }
end
