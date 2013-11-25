class Picturemem < ActiveRecord::Base
  mount_uploader :memimage, MemimageUploader
  belongs_to :picture

  def self.show_mems(type,current_user)
    if type == "my"
      pictures = Picture.user_pictures(current_user)
      @mems = []
      pictures.each do |picture|
      	picture.picturemems.each do |mem_m|
      		@mems << mem_m
      	end
      end
	else
	  @mems = Picturemem.all	
    end
    @mems
  end
end
