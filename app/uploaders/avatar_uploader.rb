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
    process :resize_to_fill => [300, 300]
  end

  version :thumbnail do
   resize_to_fit(50, 50)
  end
end
