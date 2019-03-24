class Message
  def self.not_found(record = 'record')
    "Dislcupa, #{record} no encontrado."
  end

  def self.invalid_credentials
    'Credenciales Invalidas'
  end

  def self.invalid_token
    'Token Invalido'
  end

  def self.missing_token
    'Token no esta presente, revisa los headers'
  end

  def self.unauthorized
    'Request No Autorizado'
  end

  def self.account_created
    'Cuenta creada satisfactioriamente'
  end

  def self.account_not_created
    'La cuenta no fue creda con exito'
  end

  def self.expired_token
    'Lo sentimos tu sesion ha expirado. Haz login para continuar.'
  end
end
