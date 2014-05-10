require 'spec_helper'

describe Season do
  it { should validate_presence_of :name }
end
