class Organization < ApplicationRecord
  belongs_to :user
  has_many :employees

  mount_uploader :logo, OrganizationLogoUploader
end
