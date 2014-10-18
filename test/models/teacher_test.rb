require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  test "have many rooms" do
    teacher = teachers(:one)
    assert_equal 'ABC1', teacher.rooms.first.code
  end
end
