class AddContentToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :content, :string
  end
end
