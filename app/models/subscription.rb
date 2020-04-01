# frozen_string_literal: true

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :program, counter_cache: :users_count
end
