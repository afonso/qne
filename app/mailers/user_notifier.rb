class UserNotifier < ApplicationMailer
  default :from => 'central@queronaescola.com.br'

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Você está cadastrado no Quero na Escola!' )
  end

  def send_add_email(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Você foi adicionando em um pedido no Quero na Escola!' )
  end

  def send_created_email(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Você criou um pedido no Quero na Escola!' )
  end

end
