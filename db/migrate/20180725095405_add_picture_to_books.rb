class AddPictureToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :picture, :string
    add_column :books, :status, :boolean, default: true
  end
end
