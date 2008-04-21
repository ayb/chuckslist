class Category < ActiveRecord::Base
  has_many :ads
  belongs_to :parent_category
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_length_of :name, :within => 4..40
  validates_presence_of :slug
  validates_uniqueness_of :slug, :case_sensitive => false
  validates_length_of :slug, :within => 3..40
  
  
  
  # set default categories
  def self.set_defaults
    if self.find(:all).blank?
      # set default parents
      ParentCategory.set_defaults
      
      # parent: "for sale"
      c = self.create(:name => 'books', :slug => 'bks', :parent_category_id => 1)
      c = self.create(:name => 'cars & trucks', :slug => 'car', :parent_category_id => 1)
      c = self.create(:name => 'electronics', :slug => 'ele', :parent_category_id => 1)
      
      # parent: "jobs"
      c = self.create(:name => "admin / office", :slug => 'ofc', :parent_category_id => 2)
      c = self.create(:name => 'customer service', :slug => 'csr', :parent_category_id => 2)
      c = self.create(:name => 'writing / editing', :slug => 'wri', :parent_category_id => 2)
      
      # parent: "services"
      c = self.create(:name => 'computer', :slug => 'cps', :parent_category_id => 3)
      c = self.create(:name => 'financial', :slug => 'fns', :parent_category_id => 3)
      c = self.create(:name => 'real estate', :slug => 'rts', :parent_category_id => 3)
      
      # parent: "gigs"
      c = self.create(:name => 'event', :slug => 'evg', :parent_category_id => 4)
      c = self.create(:name => 'labor', :slug => 'lbg', :parent_category_id => 4)
      c = self.create(:name => 'talent', :slug => 'tlg', :parent_category_id => 4)
    end
  end
  
  def self.display_paged_data(page)
    paginate(:page => page, :per_page => 10,:order => "name")
  end

end
