class IncomingMessage < ActiveRecord::Base
  attr_accessible :from, :photo_content_type, :photo_file_name, :photo_file_size, 
                  :photo_updated_at, :width, :height
  belongs_to :album
  
  has_attached_file :photo, 
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension"
    
    def save_photo(name, type, data)
      self.photo = Paperclip::string_to_file(name, type, data)
      dimensions = Paperclip::Geometry.from_file(self.photo.queued_for_write[:original].path)
      @width = dimensions.width
      @height = dimensions.height
    end
    
  
end
