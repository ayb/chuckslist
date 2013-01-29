class <%= controller_class_name %>Controller < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || <%= class_name %>.count > 0
  end

  def login
    return unless request.post?
    self.current_<%= file_name %> = <%= class_name %>.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_<%= file_name %>.remember_me
        cookies[:auth_token] = { :value => self.current_<%= file_name %>.remember_token , :expires => self.current_<%= file_name %>.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/<%= controller_file_name %>', :action => 'index')
      flash[:notice] = "Logged in successfully"
    end
  end

  def signup
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
    return unless request.post?
    @<%= file_name %>.save!
    self.current_<%= file_name %> = @<%= file_name %>
    redirect_back_or_default(:controller => '/<%= controller_file_name %>', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_<%= file_name %>.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/<%= controller_file_name %>', :action => 'index')
  end
end
