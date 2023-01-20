class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  before_create :confirmation_token
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email
  has_one_attached :avatar, dependent: :destro
  enum role: %i[employee admin]


  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end


  def user_image_url
    avatar.attached? ? url_for(avatar) : nil
  end


  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
  end


  

end
