# frozen_string_literal: true

class Subscription < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :program_id, message: I18n.t('subscription.already_exists') }

  belongs_to :user
  belongs_to :program, counter_cache: :users_count
end
