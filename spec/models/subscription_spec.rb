# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:program).counter_cache(:users_count) }
end
