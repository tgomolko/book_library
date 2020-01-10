class Book < ApplicationRecord
  has_many :charges
  has_many :users, through: :charges

  has_attached_file :document, { url: '/document/:id/:filename',
                                 path: "public/document/:id/:filename" }
  validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/epub application/djvu) }

  mount_uploader :image, ImageUploader

  def bought?(user)
    users.include?(user)
  end
end
