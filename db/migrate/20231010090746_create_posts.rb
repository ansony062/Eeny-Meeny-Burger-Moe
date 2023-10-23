class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id,  null: false
      t.string :name,      null: false
      t.string :shop_name, null: false
      t.string :place,     null: false
      t.string :review,    null: false
      t.text :body,        null: false

      t.timestamps
    end
  end
end
