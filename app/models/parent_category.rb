class ParentCategory < ActiveRecord::Base
  has_many :categories do

    def in_order
      find(:all, :order => 'name ASC')
    end


  end


  def all_ads
    @subcats = self.categories
    @results = []
    @subcats.each { |c| c.ads.all_active.each { |a| @results << a } }

    return @results
  end


  def self.set_defaults
    if self.find(:all).blank?
      c = self.create(:name => 'for sale', :slug => 'forsale')
      c = self.create(:name => 'jobs', :slug => 'jobs')
      c = self.create(:name => 'services', :slug => 'svcs')
      c = self.create(:name => 'gigs', :slug => 'gigs')
    end
  end

  def self.display_paged_data(page)
    self.paginate(:page => page, :per_page => 10,:order => "name")
  end
end
