class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  process :convert => 'png'

  def default_url(*args)
    ActionController::Base.helpers.asset_path("Placeholder.png")
  end

  
  version :standard do
    eager
    process :resize_to_limit => [300, 300]
  end

  version :thumbnail do
    eager
    process resize_to_fill: [100, 100]
  end
end
