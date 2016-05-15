class PagesController < ApplicationController
  def show
    @contact = Contact.new
    render template: "pages/#{params[:page]}"
  end
end
