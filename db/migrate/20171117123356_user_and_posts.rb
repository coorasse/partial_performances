class UserAndPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :posts do |t|
      t.string :title
      t.references :user
      t.timestamps
    end
  end
end
