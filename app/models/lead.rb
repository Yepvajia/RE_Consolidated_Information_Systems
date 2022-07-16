require 'dropbox_api'

class Lead < ApplicationRecord

    has_one_attached :file
    # has_one_attached :image
    # after_create :test_dropbox
    def file_on_disk
        ActiveStorage::Blob.service.path_for(file.key)
    end
end
