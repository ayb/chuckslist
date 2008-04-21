class MainController < ApplicationController

  def index
    @parent_categories = ParentCategory.find :all, :order => 'name ASC'
    @categories = Category.find :all, :order => 'name ASC'
    # redirect to setup function for now if there are no categories
    if @categories.blank?
      flash[:warning] = "No categories are set up.  Either add them in the Admin section, or run 'rake db:fixtures:import'.<br/>(Refer to README file for installation instructions.)"
    end
  end
  
  
end
