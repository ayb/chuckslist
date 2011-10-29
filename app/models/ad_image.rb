class AdImage < ActiveRecord::Base

  belongs_to :ad

  # allow image attachments
  has_attachment :content_type => :image,
                 :max_size => 1.megabytes,
                 :storage => :file_system,
                 # uncomment the next line to use S3 (you'll need to set it up and add a config)
                 # :storage => :s3,

                 # uncomment the next line to generate thumbnails
                 :thumbnails => { :thumb => 70, :show => ">500x500" },
                 :processor => :mini_magick

  validates_as_attachment

end
