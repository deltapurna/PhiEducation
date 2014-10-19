require 'test_helper'

class RoomPolicyTest < ActiveSupport::TestCase
  test "anyone can create the room" do
    room = Room.new
    policy = Pundit.policy(nil, room)
    assert_equal true, policy.create?
  end

  test "anyone can view any existing room" do
    room = rooms(:one) 
    policy = Pundit.policy(nil, room)
    assert_equal true, policy.show?
  end

  test "associated teacher can destroy a room" do
    room = rooms(:one) 
    policy = Pundit.policy(room.teacher, room)
    assert_equal true, policy.destroy?
  end

  test "non associated teacher can't destroy a room" do
    room = rooms(:one) 
    policy = Pundit.policy(teachers(:two), room)
    assert_equal false, policy.destroy?
  end
end
