# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #@TODO - both methods will be removed - next commit
  # Placeholder method - email address constant
  def garbage_email_address
    "garbage@chuckslist.org"
  end
 
  # Generate random number from values
 def random(values = nil)
   if values.respond_to? :sort_by
     values.sort_by { rand }.first
   else 
     rand(values)
   end
 end
 
 def is_admin
   if logged_in? && current_user.isAdmin
     return true
  else
    return false
  end
 end
 
 def rss_url(slug)
 	if slug
	  return '/' + slug + '/feed' 
	else       
	  return '/feed' 
  end
 end

end
