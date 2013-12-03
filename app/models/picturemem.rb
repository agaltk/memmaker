class Picturemem < ActiveRecord::Base
  mount_uploader :memimage, MemimageUploader
  belongs_to :picture
  belongs_to :user

  def self.show_mems(type,current_user)
    if type == "my"
      @mems = where(user_id: current_user.id)
      
	  else
	    @mems = Picturemem.all	
    end
    @mems
  end

end
