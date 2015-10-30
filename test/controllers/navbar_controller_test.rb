require 'test_helper'

class NavbarControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
