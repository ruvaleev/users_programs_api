# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject { subscription }

  let(:subscription) { build :subscription }

  it { should belong_to(:user) }
  it { should belong_to(:program).counter_cache(:users_count) }
  it {
    should validate_uniqueness_of(:user_id).scoped_to(:program_id)
                                           .with_message(I18n.t('subscription.already_exists'))
  }
end
