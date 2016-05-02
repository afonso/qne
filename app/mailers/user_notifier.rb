class UserNotifier < ApplicationMailer
  default :from => 'central@queronaescola.com.br'

  def send_new_user_message(user)
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

  def send_approved_mail(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Pedido aprovado no Quero na Escola!' )
  end

  def send_propo_approved_mail(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Proposta aprovada no Quero na Escola!' )
  end

  def send_marked_mail(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Pedido marcado no Quero na Escola!' )
  end

  def send_proposal_mail(user, demand)
    @user = user
    @demand = demand
    mail( :to => @user.email,
    :subject => 'Proposta criada no Quero na Escola!' )
  end
end
