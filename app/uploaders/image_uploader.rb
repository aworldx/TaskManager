# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
