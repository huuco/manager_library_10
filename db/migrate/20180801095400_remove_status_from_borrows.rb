class RemoveStatusFromBorrows < ActiveRecord::Migration[5.2]
  def change
    remove_column :borrows, :status, :integer
  end
end
