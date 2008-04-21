class Mailman < ActionMailer::Base
  helper :application 
  
  def receive(email)
    ad_enquiry_email_regex = /^\d{18}@(chuckslist.org)$/
    #post_confirmation_email_regex = /^([a-zA-Z]{22}@(chuckslist.org))$/
    if ad_enquiry_email_regex.match(email.to[0])
      Mailman.deliver_forward_email(email)
    else
      #catch all - decision? Junk the email or
      # redirect to garbage@chuckslist.com?
      Mailman.deliver_forward_email(email)
    end  
  end
  
  # this e-mail gets send for confirmation before the ad is activated
   def confirmation_email(ad, author)
    recipients author
    from       "ChucksList <postman@chuckslist.org>"
    subject    "Your Ad Activation"
    body       :ad => ad
  end
  
  # this e-mail gets sent after activation
  def activation_email(ad, author)
    recipients author
    from       "ChucksList <postman@chuckslist.org>"
    subject    "Your Ad Has Been Activated"
    body       :ad => ad
  end   
  
  # this gets sent when password has been reset
  def password_reset_email(user, password)
    recipients user
    from       "ChucksList <postman@chuckslist.org>"
    subject    "Your Password Has Been Reset"
    body       :password => password
  end
 
#-------------------------------------------------------------------------------
private
  def forward_email(email)
    recipients  unmulch(email.to)
    from        email.from
    subject     email.subject
    body        :email => email
  end
  
  def unmulch(mulched_address)
    @ad = Ad.find(:first, :conditions => ["email = ?", mulched_address])
    if @ad.nil?
      JUNK_MAIL
    else
      @ad.author.email
    end
  end

end
