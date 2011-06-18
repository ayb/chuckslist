class Mailman < ActionMailer::Base
  helper :application 
  default :from => "KanyChucksList <postman@chuckslist.org>"  
  
  def receive(email)
    ad_enquiry_email_regex = /^\d{18}@(chuckslist.org)$/
    #post_confirmation_email_regex = /^([a-zA-Z]{22}@(chuckslist.org))$/
    if ad_enquiry_email_regex.match(email.to[0])
      Mailman.forward_email(email).deliver
    else
      #catch all - decision? Junk the email or
      # redirect to garbage@chuckslist.com?
      Mailman.forward_email(email).deliver
    end  
  end
  
  # this e-mail gets send for confirmation before the ad is activated
   def confirmation_email(ad, author)     
    @ad = ad 
    mail(
      :subject    => "Your Ad Activation",
      :to         => author
    )
  end
  
  # this e-mail gets sent after activation
  def activation_email(ad, author)
    @ad = ad
    mail(
      :subject    => "Your Ad Has Been Activated",
      :to         => author
    )
  end   
  
  # this gets sent when password has been reset
  def password_reset_email(user, password)
    @password = password
    mail(
      :subject    => "Your Password Has Been Reset",
      :to         => user 
    )
  end
 
#-------------------------------------------------------------------------------
private
  def forward_email(email)
    @email = email
    mail(
      :subject    => email.subject,
      :from       => email.from,
      :to         => unmulch(email.to)      
    )
  end
  
  def unmulch(mulched_address)
    @ad = Ad.where(:email => mulched_address).first
    if @ad.nil?
      JUNK_MAIL
    else
      @ad.author.email
    end
  end

end
