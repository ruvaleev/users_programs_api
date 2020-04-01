# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :subscriptions, dependent: :destroy
  has_many :programs, through: :subscriptions
end
