# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let(:user) { build :user }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:programs).through(:subscriptions) }

  describe '.active_programs' do
    let(:program) { create(:program) }
    let!(:active_subscription) { create(:subscription, program: program, user: user, active: true) }
    let!(:inactive_subscription) { create(:subscription, user: user, active: false) }
    let(:user) { create(:user) }

    it 'returns only programs with active subscription' do
      expect(user.active_programs).to eq [program]
    end
  end
end
