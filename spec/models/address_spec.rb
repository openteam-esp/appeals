# encoding: utf-8

require 'spec_helper'

describe Address do
  it { should belong_to(:appeal) }
  it { should validate_presence_of(:postcode) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:district) }
  it { should validate_presence_of(:township) }
end

