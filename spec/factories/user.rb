# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n| "#{FFaker::Internet.email}#{n}" end
    name { FFaker::Name.name }
  end
end
