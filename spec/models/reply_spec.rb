# encoding: utf-8

require 'spec_helper'

describe Reply do
  it { should have_many(:uploads).dependent(:destroy) }
end
