class AddHomeImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Home_image, :string
  end
end
