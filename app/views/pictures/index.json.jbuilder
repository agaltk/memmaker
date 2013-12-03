json.array!(@pictures) do |picture|
  json.extract! picture, :title, :added, :image, :private
  json.url picture_url(picture, format: :json)
end
