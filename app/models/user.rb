# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  name            :string(100)
#  password_digest :string(60)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  self.table_name = "users"
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save {|user| user.email = email.downcase}

  validates :name, presence: true, length: {maximum: 49}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    format:         {with: VALID_EMAIL_REGEX},
    uniqueness:     {case_sensitive: false}
  validates :password, :password_confirmation, presence: true, length: {minimum: 3}, if: Proc.new { |user|
    user.new_record? or user.password
  }

  def to_s
    self.name || self.email.split("@").first
  end
end
