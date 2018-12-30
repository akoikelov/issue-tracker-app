require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  test "gen_token method returns 32-length hash" do
    invite = Invite.new(email: 'test@test.com')
    token = invite.instance_eval('gen_token')

    assert_equal 32, token.length
  end
end
