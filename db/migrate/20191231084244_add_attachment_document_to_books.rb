class AddAttachmentDocumentToBooks < ActiveRecord::Migration[5.2]
  def change
    add_attachment :books, :document
  end
end
