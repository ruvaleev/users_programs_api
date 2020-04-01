# frozen_string_literal: true

FactoryBot.define do
  factory :program do
    sequence :title do |n| "#{FFaker::Lorem.word} #{n}" end
    description { FFaker::Lorem.sentence }
  end
end
