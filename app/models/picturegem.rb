class Picturegem < ActiveRecord::Base
  mount_uploader :gemimage, GemimageUploader
  belongs_to :picture

  def self.show_gems(type,current_user)
    if type == "my"
      pictures = Picture.user_pictures(current_user)
      @gems = []
      pictures.each do |picture|
      	picture.picturegems.each do |gem_m|
      		@gems << gem_m
      	end
      end
	else
	  @gems = Picturegem.all	
    end
    @gems
  end
end
