class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      
      t.string :name, null: 

      t.timestamps
    end
    #同じタグは２回保存されない
    add_index :tags, :name, unique: true
  end
end
