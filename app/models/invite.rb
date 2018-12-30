class Invite < ApplicationRecord
  belongs_to :organization

  before_create :set_token

  def set_token
    if token.nil?
      self.token = gen_token
    end
  end

  private

  def gen_token
    temp = (email + rand(10000000).to_s).split('').shuffle.join
    Digest::MD5.hexdigest temp
  end
end
