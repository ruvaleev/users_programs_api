# frozen_string_literal: true

FactoryBot.define do
  factory :program do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end
end
