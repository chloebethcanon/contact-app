class Contact < ActiveRecord::Base

  belongs_to :user
  has_many :grouped_contacts
  has_many :groups, through: :grouped_contacts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :user_id, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def readable_date_time
    updated_at.strftime("%b %d, %Y")
  end

  def japan_country_code
    "+81 #{phone_number}"
  end

  def self.by_letter(letter)
    where("last_name LIKE ?", "#{letter}%").order(:last_name)
  end

end
