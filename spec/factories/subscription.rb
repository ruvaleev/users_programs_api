# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    build_association { :user }
    build_association { :program }
  end
end
