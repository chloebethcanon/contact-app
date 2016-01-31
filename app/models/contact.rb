class Contact < ActiveRecord::Base

  belongs_to :user
  has_many :grouped_contacts
  has_many :groups, through: :grouped_contacts

  def full_name
    "#{first_name} #{last_name}"
  end

  def readable_date_time
    updated_at.strftime("%b %d, %Y")
  end

  def japan_country_code
    "+81 #{phone_number}"
  end

end
