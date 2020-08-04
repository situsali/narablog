class Medium < ApplicationRecord
  mount_uploader :file, MediaUploader
end
