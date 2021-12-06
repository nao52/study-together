class CreateGroupPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_posts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
