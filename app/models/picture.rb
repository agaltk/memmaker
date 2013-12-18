class Picture < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :picturemems
  belongs_to :user
  scope :not_private, -> { where(private: false) }

  
  def createmem(text='Default text',userid)

	  img = self.image.file.file
    font_size = 25
    img = Magick::Image.read(img).first
    my_text = text
    img = img.resize_to_fill(480, 320)
    img = img.border(50,50,Magick::Pixel.new(0,0,0))
    img = img.chop(0,0,40,40)
    img = img.chop(500,0,40,0)
    copyright = Magick::Draw.new
    copyright.font = 'Helvetica'
    copyright.pointsize = font_size
    copyright.font_weight = Magick::BoldWeight
    copyright.fill = 'white'
    copyright.gravity = Magick::SouthGravity
    
    copyright.annotate(img, 0, 0, 2, 5, my_text)
    path = 'tmp/uploads/mem'+ Random.new(1234).rand(1..9999999).to_s+'.png'
    img.write(path)

    memimage = MemimageUploader.new
    memimage.cache!(File.open(path))
    pg =  Picturemem.create(title: my_text, memimage: memimage, user_id: userid)
    self.picturemems << pg
    self.save
    pg
  end

  def self.user_pictures(user)
    where(user_id: user.id).order(created_at: :desc)
  end

  def self.show_pictures(type,current_user)
  
    if type == "my"
      @pictures = Picture.user_pictures(current_user)
   
    else
      @pictures = Picture.all.order(created_at: :desc)
    end
  
    @pictures
  end


end
