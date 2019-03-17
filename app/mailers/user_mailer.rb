class UserMailer < ApplicationMailer

  def forgot_password(user)
    @user = user
    mail(to: user.email, subject: "Recuperacion de Contraseña")
  end

  def new_account(user, temp)
    @user = user
    @temp = temp
    mail(to: user.email, subject: "Nueva Cuenta Facturas Electronicas BSC")
  end
end
