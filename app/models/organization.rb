class Organization < ApplicationRecord
  belongs_to :user
  has_many :employees
  has_many :roles

  has_many :users, through: :employees

  alias_attribute :employee_users, :users
  alias_attribute :owner, :user

  mount_uploader :logo, OrganizationLogoUploader

  validates :title, presence: true

end
