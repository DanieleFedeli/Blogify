CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  
  module MiniMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
end
