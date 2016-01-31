require 'rails_helper'

describe ContactsController do

  describe 'GET #show' do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :show, id: contact
      expect(assigns(:contact)).to eq contact
    end

    it "renders the :show template" do
      contact = create(:contact)
      get :show, id: contact
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :edit, id: contact
      expect(assigns(:contact)).to eq contact
    end

    it "renders the :edit template" do
      contact = create(:contact)
      get :edit, id: contact
      expect(response).to render_template :edit
    end
  end

end