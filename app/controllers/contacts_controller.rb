class ContactsController < ApplicationController

  def index

    if current_user
      @contacts = Contact.order(:last_name, :first_name).where(user_id: current_user.id)
    else
      redirect_to '/users/sign_in'
    end

    if params[:group]
      @contacts = Group.find_by(name: params[:group]).contacts.where(user_id: current_user.id)
    end

  end

  def new
  end

  def create
    @contact = Contact.create(
      first_name: params[:first_name], 
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      user_id: current_user.id
      )
    flash[:success] = "Contact was successfully created!"
    redirect_to "/contacts"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:first_name], 
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
      )
    flash[:success] = "Contact was successfully updated!"
    redirect_to "/contacts/#{contact.id}"
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.delete
    flash[:success] = "Contact was successfully deleted!"
    redirect_to "/contacts"
  end

end
