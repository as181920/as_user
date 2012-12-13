module AsUser
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
    validates :password, presence: true, length: {minimum: 3}
    validates :password_confirmation, presence: true
  end
end

