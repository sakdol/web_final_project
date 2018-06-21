require 'test_helper'

class MusicpostsControllerTest < ActionController::TestCase
  test "should get _musicposts" do
    get :_musicposts
    assert_response :success
  end

end
