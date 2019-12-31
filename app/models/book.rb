class Book < ApplicationRecord
  belongs_to :user

  has_attached_file :document, { url: '/document/:id/:filename',
                                 path: "public/document/:id/:filename" }
  validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/epub application/djvu) }

  mount_uploader :image, ImageUploader
end
