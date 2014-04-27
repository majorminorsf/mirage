class Attachment < ActiveRecord::Base
  attr_accessible :label, :attached_file
  has_attached_file :attached_file#, styles: {thumbnail: "65x65#"}
  
  def has_image
    %w(.png .jpg .jpeg .gif .bmp).include? File.extname(self.attached_file.path || "")
  end
end
