# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :subscriptions, dependent: :destroy
  has_many :programs, through: :subscriptions

  def active_programs
    sql = "SELECT programs.* FROM programs
                              INNER JOIN subscriptions ON programs.id = subscriptions.program_id
                              WHERE subscriptions.user_id = #{id} AND subscriptions.active = true".squish

    Program.find_by_sql(sql)
  end
end
