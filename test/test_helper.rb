ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def join_as_teacher(room)
    open_session do |sess|
      sess.post_via_redirect '/teachers', { room_code: room.code }
    end
  end

  def join_as_student(room)
    open_session do |sess|
      sess.post_via_redirect '/students', { room_code: room.code }
    end
  end
end
