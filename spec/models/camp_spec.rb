require 'spec_helper'

describe Camp do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:current) }
end