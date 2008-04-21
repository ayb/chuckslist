class Author < ActiveRecord::Base
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  has_many :ads do
    
    def active
      find(:all, :conditions => ["expiration > ? and active = ?", Time.now, true])
    end
    
    def remove_all
      find(:all).each { |a| a.destroy }
    end
    
  end


  def is_banned
    self.banned = true
    self.save
  end

  def self.display_paged_data(page)
    paginate(:page => page, :per_page => 10,:order => "id")
  end

end
