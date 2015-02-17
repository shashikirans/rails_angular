class User < ActiveRecord::Base
  
  has_secure_password
  before_save :generate_auth_token

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

  def self.authenticate(login_handle, password)
    user = User.where("LOWER(email) = LOWER('#{login_handle}')").first
    authenticated = false
    heading = I18n.translate("authentication.error")
    alert = I18n.translate("authentication.invalid_login")

    # If the user exists with the given username / password & Check if the password matches
    if user && user.authenticate(password)
      heading = I18n.translate("authentication.success")
      alert = I18n.translate("authentication.logged_in_successfully")
      authenticated = true
    end

    return authenticated, user, heading, alert
  end

end
