class Picturemem < ActiveRecord::Base
  mount_uploader :memimage, MemimageUploader
  belongs_to :picture
  belongs_to :user

  def self.show_mems(type,current_user)
    if type == "my"
      @mems = where(user_id: current_user.id).order(created_at: :desc)
      
	  else
	    @mems = Picturemem.all.order(created_at: :desc)
    end
    @mems
  end

end
