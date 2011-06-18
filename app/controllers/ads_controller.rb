class AdsController < ApplicationController

  # show one particular ad
  def show
    @ad = Ad.find(params[:id])
    if (@ad.nil?)
      flash[:warning] = 'Error - That Ad Does Not Exist'
      redirect_to root_path
    end
    
    @category = @ad.category
  end
  
  # destroy ad with that particular hash
  def destroy
    if request.post?
      @ad = Ad.where(:activation_hash => params[:id]).first
      if (@ad.nil?)
        flash[:warning] = 'Error - That Ad Does Not Exist'
        redirect_to root_path
        # report to admin?
      else
        # destroy the ad
        @ad.destroy
        flash[:notice] = 'Your Ad Has Been Removed'
        redirect_to root_path
      end
    end
  end
  
  # show a list of ads in a category
  # we need a clever way to do this - if both parent and child categories 
  # have a page slug how to identify one vs. the other?  might be easier to 
  # inherit then do this code checking tfor a blank array..
  def list
    @slug = params[:slug]
    @ads = Ad.all_active_by_slug(params[:slug])
    if !@ads
      flash[:warning] = 'Invalid Request'
      redirect_to root_path
    end
  end
  
  
  # show parent category list for new ad
  def post
    @parents = ParentCategory.order("name ASC")
  end
  

  # ajaxy function to show subcategories when they select a parent
  def select_category
    @parent_category = ParentCategory.find(params[:id])
  end
  
  # show the ajaxy form for a new ad
  def show_form
    @category = Category.find(params[:id])
  end
  
  # ajaxy - create new ad
  def new
    if (params[:email] != params[:email_verify])
      # return an error since email and confirmation don't match
      flash[:warning] = 'Email Address and Email Confirmation Do Not Match'
      #@category = params[:category]
      # TODO
      # can we somehow send them to the last screen?
      redirect_to :controller => 'ads', :action => 'post'
    else
      # email and confirmation match
      @author = Author.where(:email => params[:email]).first
      if @author.blank?
        @author = Author.new
        @author.email = params[:email]
        @author.ip = request.env['REMOTE_ADDR']
        @author.save
      end
      @ad = Category.find(params[:category]).ads.new
      @ad.title = params[:title]
      @ad.ad = params[:ad].gsub("\n", "<br/>")
      @ad.expiration = Time.now + 30.days
      @ad.author = @author
      
      # record author IP address
      @ad.author_ip = request.env['REMOTE_ADDR']
      @ad.save
      
      # handle image attachments
      @ad.handle_images(params[:image_attachments])     

      # send confirmation email with activation url
      Mailman.confirmation_email(@ad, @author.email).deliver
      flash[:notice] = 'A Confirmation Email Has Been Sent To ' + @author.email
      
    end
  end
  
  # activate an ad that is new but not active yet
  def activate
    @ad = Ad.where(:activation_hash => params[:activation_hash]).first
    if (@ad.nil?)
      flash[:warning] = 'Error Activating Your Ad'
      redirect_to root_path
      #report to admin?
    else
      # not sure we need this?
      #respond_to do |format|
        #redirect to confirmation thank you page
        if @ad.activate(params[:activation_hash])
          flash[:notice] = 'Your Ad Has Been Activated - An Email Has Been Sent To ' + @ad.author.email
          Mailman.activation_email(@ad, @ad.author.email).deliver
          #redirect_to :action => 'show', :id => @ad
          redirect_to :action => 'edit', :activation_hash => @ad.activation_hash
        else
          flash[:warning] = 'Error Activating Your Ad'
          redirect_to root_path
        end
        #format.html {render :action => "confirmed"}
      #end
    end
  end
  
  
  # manage an ad based on the hash
  def manage
    @ad = Ad.where(:activation_hash => params[:activation_hash]).first
    if (@ad.nil?)
      flash[:warning] = 'Error - That Ad Does Not Exist'
      redirect_to root_path
      # report to admin?
    else
      # show the ad and let them edit it
      # going to use our own rhtml with edit buttons etc.
      #render :action => 'show'
    end
  end
  
  # edit an ad based on the hash
  def edit
    @ad = Ad.where(:activation_hash => params[:activation_hash]).first
    if (@ad.nil?)
      flash[:warning] = 'Error - That Ad Does Not Exist'
      redirect_to root_path
      # report to admin?
    else
      # show the ad and let them edit it
    end
  end
  
  # update an ad after someone edits (via the edit form) and hits 'submit'
  def update
    @ad = Ad.where(:activation_hash => params[:activation_hash]).first
    if (@ad.nil?)
      flash[:warning] = 'Error - That Ad Does Not Exist'
      redirect_to root_path
      # report to admin?
    else
      @ad.ad = params[:ad].gsub("\n", "<br/>")
      @ad.title = params[:title]
      if @ad.save
        
        # handle image attachments
        @ad.handle_images(params["image_attachments"])
        
        flash[:notice] = "Ad Updated Successfully"
      else
        flash[:warning] = "Error Updating Ad"
      end
      redirect_to :controller => 'ads', :action => 'manage', :activation_hash => @ad.activation_hash
    end    
  end
  
  def delete_image
    @ad = Ad.where(:activation_hash => params[:activation_hash]).first
    @ad_image = @ad.ad_images.find(params[:id])
    
    if @ad_image.destroy
      flash[:notice] = "Ad Image Deleted"
    else
      flash[:warning] = "Unable to Find Ad Image to Delete"
    end
    
    redirect_to :controller => 'ads', :action => 'manage', :activation_hash => @ad.activation_hash
  end
  
  
  # rss feed for the whole site
  def feed
    @ads = Ad.all_active
    
    respond_to do |format|
      format.rss { render :layout => false }
      format.atom # index.atom.builder
    end
  end
  
  # rss feed for just one category
  def category_feed
    @ads = Ad.all_active_by_slug(params[:slug])
    
    respond_to do |format|
      format.rss { render :layout => false }
      format.atom # index.atom.builder
    end
  end
  
  
end
