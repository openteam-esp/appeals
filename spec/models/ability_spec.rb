# encoding: utf-8

require 'spec_helper'

describe Ability do
  let(:ability) { Ability.new(user) }

  it { ability.should be_able_to(:create, Fabricate(:reply, :appeal => reviewing_appeal)) }
  it { ability.should be_able_to(:update, Fabricate(:reply, :appeal => reviewing_appeal)) }

  it { ability.should be_able_to(:destroy, fresh_appeal) }

  it { ability.should be_able_to(:close, Fabricate(:appeal)) }
  it { ability.should be_able_to(:restore, Fabricate(:appeal)) }
  it { ability.should be_able_to(:review, Fabricate(:appeal)) }
  it { ability.should be_able_to(:revert, Fabricate(:appeal)) }

  it { ability.should be_able_to(:create, registered_appeal.build_note(Fabricate.attributes_for(:note))) }
  it { ability.should be_able_to(:create, registered_appeal.build_redirect(Fabricate.attributes_for(:redirect))) }
  it { ability.should be_able_to(:create, registered_appeal.build_review(Fabricate.attributes_for(:review))) }
end
