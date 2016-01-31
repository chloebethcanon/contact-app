require 'rails_helper'

describe Contact do
  it "is valid with a first_name, last_name, email, phone_number and user_id" do
    contact = Contact.new(
      first_name: 'Testy',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      user_id: 100)
    expect(contact).to be_valid
  end

  it "is invalid without a first_name"
  it "is invalid without a last_name"
  it "is invalid without an email address"
  it "is invalid with a duplicate email address"
  it "is invalid without a phone_number"
  it "is invalid without a user_id"
  it "returns a contact's full name as a string"
end