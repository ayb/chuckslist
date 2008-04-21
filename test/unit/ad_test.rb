require File.dirname(__FILE__) + '/../test_helper'

class ClassifiedAdTest < ActiveSupport::TestCase
  
  #check log/test.log for generated UUID
  def test_ad_creation
    ad = Ad.create(:title => ads(:test_one).title)
    assert ad.valid?
    assert_equal(ads(:test_one).title, ad.title)
    assert_equal(false, ad.active)
    assert !ad.activation_hash.nil?
  end
  
  def test_email_generation_is_working
    ad = Ad.create(:title => ads(:test_one).title)
    assert ad.valid?
    assert_match(/^\d{18}@(chuckslist.com)$/i, ad.email)
  end
  
  def test_no_clash_in_generated_email_address
    # Simulate 10000 simultaneous email address generated via Ad creation
    # this will take a while to complete
    for count in (1..10000)
      ad1 = Ad.create(:title => 'Ad1')
      ad2 = Ad.create(:title => 'Ad2')
      assert_not_equal(ad1.email, ad2.email)
    end
  end
  
  def test_created_ads
    #ad = Ad.create(:title => 'Ad')
    #assert_equal('user', ad.user.email)
  end
end
