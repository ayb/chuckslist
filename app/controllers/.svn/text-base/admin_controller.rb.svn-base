class AdminController < ApplicationController
  include AuthenticatedSystem
  
  before_filter :login_required
  
  def index
   if (!current_user.isAdmin)
    redirect_to :controller => 'main', :action => 'index'
   end
  end
    
  def manager
    #@ads = Ad.find(:all)
    @display_data = Ad.display_paged_data(params[:page])
  end
  
  def authors
    @display_data = Author.display_paged_data(params[:page])
  end
  
  def category
    @display_data = Category.display_paged_data(params[:page])
    @parents = ParentCategory.find(:all)
    @parent_categories = @parents.collect { |p| [p.name, p.id] }
  end
    
  def create_category
    if request.post? && params[:new_category] != ""
      begin
        @category = Category.new
        @category.name = params[:new_category]
        @category.slug = params[:new_category].split.join.downcase
        @category.parent_category_id = params[:ParentCategory][:id]
        @category.save!
        flash[:notice] = "New Category Created"
      end
    end
    redirect_to :action => 'category'
  end
  
  def delete_cat
    if request.post?
      cat = Category.find(params[:id])
      cat.destroy
      flash[:notice] = "Category deleted"
      redirect_to :action => 'category'
    end
    redirect_to :action => 'category'
  end
  
  def parent_category
    @display_data = ParentCategory.display_paged_data(params[:page])
  end
  
  def create_parent_category
    if request.post? && params[:parent_category] != ""
      begin
        @parent = ParentCategory.new
        @parent.name = params[:parent_category]
        #simple way to generate the slug
        @parent.slug = params[:parent_category].split.join.downcase
        @parent.save!
        flash[:notice] = "Parent Category Created"
      end
    end
    redirect_to :action => 'parent_category'
  end
  
  def del_parent
    #Add check for child dependencies in the model
    if request.post?
      parent = ParentCategory.find(params[:id])
      parent.destroy
      flash[:notice] = "Parent Category deleted"
      redirect_to :action => 'parent_category'
    end
  end
  
  def delete_author_and_ads
    @author = Author.find_by_id(params[:id])
    if request.post? && !@author.nil?
      @author.ads.remove_all
      @author.is_banned
      flash[:notice] = "Author has been banned and all ads removed"
    else
      flash[:warning] = "Error - unable to delete author and ads"
    end
    redirect_to :action => "authors"
  end
  
  
  def user
    @display_data = User.display_paged_data(params[:page])
  end
  
  def delete_user
    #simple check to prevent last user to be deleted
    if request.post? && User.count > 1
        user = User.find(params[:id])
        user.destroy
        flash[:notice] = "User removed"
      end
    redirect_to :action => 'user'
  end
  
  def toggle_user_admin
    if request.post?
          user = User.find(params[:id])
          if user.isAdmin
            user.isAdmin = false
            flash[:notice] = "Admin status removed from user"
          else
            user.isAdmin = true
            flash[:notice] = "User has admin status"
          end
          user.save!
        end
    redirect_to :action => 'user'
  end
   
  def expire_ad
    if request.post?
      ad = Ad.find(params[:id])
      ad.expire!
      flash[:notice] = "Ad has been expired"
    end
    redirect_to :action => 'manager'
  end
  
  def extend_ad
    if request.post?
      ad = Ad.find(params[:id])
      ad.extend!
      flash[:notice] = "Ad has been extended by 30 days from now"
    end
    redirect_to :action => 'manager'
  end
  
  def reset_ad
    if request.post?
      ad = Ad.find(params[:id])
      ad.reset!
      flash[:notice] = "Ad has been reset"
    end
    redirect_to :action => 'manager'
  end
  
  def delete_ad
    if request.post?
      ad = Ad.find(params[:id])
      ad.destroy
      flash[:notice] = "Ad has been deleted"
    end
    redirect_to :action => 'manager'
  end
  
  def destroy
    if logged_in?
      reset_session
      flash[:notice] = 'You have successfully logged out'      
    end
    redirect_to :controller => 'main', :action => 'index'
  end
  
  def change_password
    if (params[:old_password].empty? || params[:new_password].empty? ) 
      flash[:warning] = 'Passwords cannot be empty'
      render :action => 'pwd'
    else
      if (current_user.authenticated?(params[:old_password]))
        current_user.password = params[:new_password]
        current_user.password_confirmation = params[:confirm_password]
        begin
          current_user.save!
          flash[:notice] = 'Password successfully changed'
          redirect_to :action => "index" 
        rescue ActiveRecord::RecordInvalid => e
          flash[:warning] = "Could not change your password: #{e}"
          render :action => 'pwd'
        end
      else
        flash[:warning] = 'You supplied the wrong password'
        render :action => 'pwd'
      end
    end    
  end
  
  def reset_password
    @user = User.find_by_id(params[:id])
    if request.post? && logged_in? && current_user.isAdmin && !@user.nil?
      @new_password = @user.reset_password
      if @new_password
        Mailman.deliver_password_reset_email(@user.email, @new_password)
      else
        flash[:warning] = "Error Resetting Password"
        redirect_to :action => "user"
      end
    else
      flash[:warning] = "Invalid Request"
      redirect_to :controller => "main", :action => "index"
    end
  end
  
  def ban_user
    @user = User.find_by_id(params[:id])
    if request.post? && logged_in? && current_user.isAdmin && !@user.nil?
      @user.banned = true
      if !@user.save
        flash[:warning] = "Unable to Ban User"
        redirect_to :action => "user"
      end
    end
  end
  
  def unban_user
    @user = User.find_by_id(params[:id])
    if request.post? && logged_in? && current_user.isAdmin && !@user.nil?
      @user.banned = false
      if !@user.save
        flash[:warning] = "Unable to Un-Ban User"
        redirect_to :action => "user"
      end
    end
  end
  
  
  # not needed for now  
  # def edit_category
  #   @category = Category.find_by_id(params[:id])
  #   if @category.nil?
  #     flash[:warning] = 'Error Editing Category'
  #     redirect_to :action => 'index'
  #   end
  # end
  
  def update_category
    # update the category
    @category = Category.find_by_id(params[:id])
    if @category.nil?
      flash[:warning] = "Invalid Category"
    end
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category - #{params[:category][:name]} - has been updated"
    else
      if params[:category].nil?
        flash[:warning] = 'You Are Posting An Empty Form - No Way To Update'
      else
        flash[:warning] = "Error Updating Category"
      end
    end
    
    # fail gracefully if non ajax
    # (if we make this function ajax)
    #respond_to do |format|
    #  format.html { redirect_to :action => "category" }
    #  format.js # will just execute the RJS
    #end
    
    redirect_to :action => 'category'
  end

  # not needed for now..
  # def edit_ad
  #   @ad = Ad.find_by_id(params[:id])
  #   if @ad.nil?
  #     flash[:warning] = 'Error Editing Ad'
  #     redirect_to :action => 'index'
  #   end
  # end
  
  def update_ad
    @ad = Ad.find_by_id(params[:id])
    if @ad.nil?
      flash[:warning] = "Invalid Ad"
      redirect_to :action => 'manager'
    end
    if @ad.update_attributes(params[:ad])
      flash[:notice] = "Ad has been updated"
    else
      if params[:ad].nil?
        flash[:warning] = 'You Are Posting An Empty Form - No Way To Update'
      else
        flash[:warning] = "Error Updating Ad"
      end
    end
    redirect_to :action => 'manager'
  end
  
  def update_parent_category
    # update the category
    @parent_category = ParentCategory.find_by_id(params[:id])
    if @parent_category.nil?
      flash[:warning] = "Invalid Parent Category"
      redirect_to :action => 'parent_category'
    end
    if @parent_category.update_attributes(params[:parent_category])
      flash[:notice] = "Parent Category has been updated"
    else
      if params[:parent_category].nil?
        flash[:warning] = 'You Are Posting An Empty Form - No Way To Update'
      else
        flash[:warning] = "Error Updating Parent Category"
      end
    end
    redirect_to :action => 'parent_category'
  end

  # not going to allow editing user email address in admin menu
  # therefore this is not needed..
  # def update_user
  #   @user = User.find_by_id(params[:id])
  #   if @user.nil?
  #     flash[:warning] = "Invalid User"
  #     redirect_to :action => 'user'
  #   end
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = "User has been updated"
  #   else
  #     if params[:user].nil?
  #       flash[:warning] = 'You Are Posting An Empty Form - No Way To Update'
  #     else
  #       flash[:warning] = "Error Updating User"
  #     end
  #   end
  #   redirect_to :action => 'user'
  # end

  
  
end
