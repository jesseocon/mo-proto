require "open-uri"
class Image < ActiveRecord::Base
  
  attr_accessible :img_data, :img_url, :pic_content_type, :pic_file_name, :pic_file_size, 
                  :pic_updated_at
  
  
  has_attached_file :pic, 
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
    
    def pic_from_url(url)
      self.pic = open(url)
    end
    
    def src
      self.photo.url
    end
    
    def caption
      return "caption"
    end
end
