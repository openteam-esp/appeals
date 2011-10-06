# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { should validate_presence_of(:surname) }
end

