require 'uuid'
class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  validate :expiration_is_set
  
  def expiration_is_set
    if expiration.nil?
      expiration = Time.now + 30.days
    end
  end
  
  def expire!
    self.expiration = Time.now - 1.day
    self.save
  end
  
  def extend!
    self.expiration = Time.now + 30.days
    self.save
  end
  
  def reset!
    self.active = false
    self.save
  end
  
  def expired?
    self.expiration < Time.now
  end
  
  # TODO
  def self.fetch_by_category_slug(slug)    
  end
  
  # activate an ad
  # pass the activation hash/params as "conf"
  # let the model validate it for us
  def activate(conf)
    if self.activation_hash == conf and !self.active?
      self.active = true
      if self.save
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  
  def self.all_active
    find(:all, :conditions => ['expiration > ? and active = ?', Time.now, true], :order => 'created_at ASC')
  end
  
  def self.display_paged_data(page)
    paginate(:page => page, :per_page => 10,:order => "id")
  end
  
protected
 def before_create
    self.activation_hash = UUID.new
    #self.email = DateTime.now.to_s(:generate_hash) + rand(10000).to_s.rjust(5, '0') + "@chuckslist.com"
    self.email = DateTime.now.to_s(:generate_hash) + $generatedKeyCount.to_s.rjust(5, '0') + "@" + DOMAIN
    $generatedKeyCount = $generatedKeyCount + 1
    if ($generatedKeyCount > 99999)
      $generatedKeyCount = 1
    end
 end


  
  
  
end
