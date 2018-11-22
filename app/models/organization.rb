class Organization < ApplicationRecord
  belongs_to :user

  mount_uploader :logo, OrganizationLogoUploader
end
