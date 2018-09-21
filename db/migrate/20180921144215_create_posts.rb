class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :status
      t.string :city
      t.float :rent_with_expenses_amount
      t.string :user_id
      t.string :description
      t.string :firstname
      t.string :lastname
      t.float :property_surface
      t.string :coordinates
      t.string :address
      t.string :pictures
      t.integer :rooms_count
      t.string :property_id
      t.integer :zip_code

      t.timestamps
    end
  end
end
