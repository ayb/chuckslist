require File.dirname(__FILE__) + '/../test_helper'

class AdsControllerTest < ActionController::TestCase
  
  def test_ad_post_and_email_sent
    get :new, {:category => 1, :title => 'test', :ad => 'test ad'}
    assert_response :success
  end
  
  def test_url_click_activates_post
    assert true
  end
  
end
