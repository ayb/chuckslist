require File.dirname(__FILE__) + '/../test_helper'

class MailmanTest < ActionMailer::TestCase
  tests Mailman
  
  def test_email_fixture_is_working
    email_text = read_fixture("test_mail_001").join
    assert_match(/jalopy/i, email_text)
  end
  
  def test_receive_email_is_working
    email_text = read_fixture("test_mail_001").join
    response = Mailman.receive(email_text)
    assert_not_equal("200806159145300001@chuckslist.com", response.to[0])
    assert_equal("quentin@example.com", response.to[0])
    assert_equal("drspin_2003@hotmail.com", response.from[0])
    assert_match(/jalopy/i, response.body)
    assert_match(/Email delivered by Chuckslist/i, response.body)
  end
  
  def test_fake_email_is_garbaged
    email_test = read_fixture("test_mail_002").join
    response = Mailman.receive(email_test)
    assert_not_equal("quentin@example.com", response.to[0]) 
    assert_equal("garbage@chuckslist.org", response.to[0])
  end
  
  def test_regex_match_reply_to_ad_email
    assert_match(/^\d{18}@(chuckslist.com)$/i, "200806159145300001@chuckslist.com")
  end
  
  def test_regex_match_ad_activation_email
    assert_match(/^([a-zA-Z]{22}@(chuckslist.com))$/i, "abcdefghiJKLmnOPQrstUV@chuckslist.com")
  end
  
  def test_ad_confirmation_email_is_sent
    
  end
  
  def test_ad_confirmation_set_true_when_clicked
    
  end
  
  def test_ad_confirmation_email_is_working
    
  end
 
end
