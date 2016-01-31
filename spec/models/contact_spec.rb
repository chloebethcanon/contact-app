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

  it "is invalid without a first_name" do
    contact = FactoryGirl.build(:contact, first_name: nil)
    contact.valid?
    expect(contact.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last_name" do
    contact = Contact.new(last_name: nil)
    contact.valid?
    expect(contact.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    Contact.create(
      first_name: 'Testy',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      user_id: 100)
    contact = Contact.new(
      first_name: 'Jane',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      user_id: 101)
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a duplicate email address using factory girl" do
    FactoryGirl.create(:contact, email: 'testy@example.com')
    contact = FactoryGirl.build(:contact, email: 'testy@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a phone_number" do
    contact = Contact.new(phone_number: nil)
    contact.valid?
    expect(contact.errors[:phone_number]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    contact = Contact.new(user_id: nil)
    contact.valid?
    expect(contact.errors[:user_id]).to include("can't be blank")
  end

  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact, 
      first_name: 'Testy',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      user_id: 100)
    expect(contact.full_name).to eq 'Testy McTesterson'
  end

  it "returns the date a contact was last updated in a readable format" do
    contact = Contact.new(
      first_name: 'Testy',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      updated_at: '2016-01-30 17:00:00',
      user_id: 100)
    expect(contact.readable_date_time).to eq 'Jan 30, 2016'
  end

  it "adds the Japan country code to the phone_number" do
    contact = Contact.new(
      first_name: 'Testy',
      last_name: 'McTesterson',
      email: 'testy@example.com',
      phone_number: '555-555-5555',
      user_id: 100)
    expect(contact.japan_country_code).to eq '+81 555-555-5555'
  end

  describe "filter last name by letter" do
    before :each do
      @smith = Contact.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'jsmith@example.com',
        phone_number: '555-555-5555',
        user_id: 100)
      @jones = Contact.create(
        first_name: 'Tim',
        last_name: 'Jones',
        email: 'tjones@example.com',
        phone_number: '555-555-1234',
        user_id: 101)
      @johnson = Contact.create(
        first_name: 'John',
        last_name: 'Johnson',
        email: 'jjohnson@example.com',
        phone_number: '555-555-4321',
        user_id: 102)
    end
    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end
    context "non-matching letters" do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end

  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end
end