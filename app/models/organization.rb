class Organization < ApplicationRecord
  belongs_to :user
  has_many :employees

  alias_attribute :owner, :user

  mount_uploader :logo, OrganizationLogoUploader

  validates :title, presence: true

end
