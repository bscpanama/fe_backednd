class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    {
      auth_token: token,
      user_type: user.class.name,
      user_name: user.full_name,
      avatar_url: user_avatar,
      user_id: user.id
    }
  end

  private

  attr_reader :email, :password

  def token
    JsonWebToken.encode({user_id: user.id, user_type: user.class.name}) if user
  end

  # verify user credentials
  def user
    user = User.find_by(email: email) || Admin.find_by(email: email)
    if user.kind_of?(User)
      return user if user && user.authenticate(password) && user.account.activo?
    elsif user.kind_of?(Admin)
      return user if user && user.authenticate(password)
    end
    # raise Authentication error if account is inactive
    if user.kind_of?(User) && user.account.inactivo?
      raise(ExceptionHandler::AuthenticationError, "Cuenta Inactiva")
    end

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

  def user_avatar
    user.try(:account) ? user.account.avatar_url : "default"
  end
end
