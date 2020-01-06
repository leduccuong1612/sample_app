class User < ApplicationRecord
  before_save{self.email = email.downcase}

  validates :name, presence: true,
   length: {maximum: Settings.validate.name_length}
  validates :email, presence: true,
   length: {maximum: Settings.validate.email_length},
   format: {with: Settings.validate.regex_email},
   uniqueness: {case_sensitive: true}
  validates :password, presence: true,
   length: {minimum: Settings.validate.password_min_length}

  has_secure_password
end
