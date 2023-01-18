class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email
  enum role: %i[employee admin]



  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
    end
  end

  
end
