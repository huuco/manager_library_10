class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :birth_year
      t.string :country

      t.timestamps
    end
  end
end
