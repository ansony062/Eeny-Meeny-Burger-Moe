class AddBodyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :body, :text, null: false
  end
end
