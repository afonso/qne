class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Obrigado por nos enviar uma mensagem, aguarde o nosso retorno, obrigado!'
      redirect_to demands_path
    else
      flash[:notice] = 'Mensagem não pode ser enviada, mande um email para central@queronaescola.com.br'
      redirect_to demands_path
    end
  end
end

