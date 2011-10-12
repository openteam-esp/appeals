# encoding: utf-8

require 'spec_helper'

describe Ability do
  let(:ability) { Ability.new(user) }

  it { ability.should be_able_to(:update, Fabricate(:reply, :appeal => registered_appeal)) }
  it { ability.should_not be_able_to(:update, closed_appeal.reply) }
end
