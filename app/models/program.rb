# frozen_string_literal: true

class Program < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
end
