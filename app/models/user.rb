class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :organization
  has_many :employees

  has_many :organizations, through: :employees

  alias_attribute :work_organizations, :organizations
  alias_attribute :own_organization, :organization

  mount_uploader :avatar, UserAvatarUploader
  
  def is_organization_owner?(organization_id)
    organization.present? && organization.id == organization_id
  end

  def belongs_to_organization?(organization_id)
    work_organizations.ids.include? organization_id.to_i
  end

end
