class SearchesController < ApplicationController

  def index
     unless invalid_search?
      @ads = Ad.search(params[:search])
     else
      flash[:warning] = "Invalid Search. Enter at least 3 characters into the search box."
      redirect_to root_path
     end
  end

  def invalid_search?
    return true if params[:search].blank?
    return true if params[:search].length < 3
    # else
    return false
  end

end