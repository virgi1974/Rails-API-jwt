class V1::ContactsController < ApplicationController
  def index
    @contacts = Contact.all

    render json: @contacts, status: :ok
  end
  
  def create
    @contact = Contact.find(contact_params)

    render json: @contact, status: :ok
  end
  
  def destroy
    @contact = Contact.where(contact_params).first
    
    if @contact.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end
end
