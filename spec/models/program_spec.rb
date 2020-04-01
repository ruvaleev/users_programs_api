# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Program, type: :model do
  subject { program }

  let(:program) { build :program }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:users).through(:subscriptions) }
end
