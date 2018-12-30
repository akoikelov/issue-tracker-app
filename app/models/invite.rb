class Invite < ApplicationRecord
  belongs_to :organization
  belongs_to :role

  attr_accessor :resend

  EXPIRE_DAYS = 7

  before_create :set_attrs

  def set_attrs
    self.token = gen_token
    self.expires_at = Date.today + EXPIRE_DAYS
  end

  private

  def gen_token
    temp = (email + rand(10000000).to_s).split('').shuffle.join
    Digest::MD5.hexdigest temp
  end
end
