class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/cache/images"
  end
  version :thumb do
    process resize_to_limit: [50, 60]
  end

  version :catalog_size do
    process resize_to_limit: [160, 250]
  end

  version :show_size do
    process resize_to_limit: [555, 380]
  end

  version :slider_size do
    process resize_to_limit: [250, 400]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
