class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  before_create :confirmation_token
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email
  enum role: %i[employee admin]


  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end



  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
  end



  

end
