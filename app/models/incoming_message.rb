class IncomingMessage < ActiveRecord::Base
  attr_accessible :from, :photo_content_type, :photo_file_name, :photo_file_size, 
                  :photo_updated_at, :width, :height 
  
  belongs_to :album
  has_many :stars
  
  has_attached_file :photo, 
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension"
    
  ACCEPTABLE_FILETYPES = ["image/jpeg", "image/png"]
    
    def save_photo(name, type, data)
      self.photo = Paperclip::string_to_file(name, type, data)
      dimensions = Paperclip::Geometry.from_file(self.photo.queued_for_write[:original].path)
      self.width = dimensions.width
      self.height = dimensions.height
    end
    
    def src
      self.photo.url
    end
    
    def caption
      return "caption"
    end
  
end
