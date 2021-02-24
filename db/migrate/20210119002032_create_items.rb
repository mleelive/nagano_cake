class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      
      t.integer :category_id, null: false			
      t.string :name, null: false			
      t.text :information, null: false			
      t.string :image_id, null: false			
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
    
      add_index :items, :id,                unique: true
      
  end
end
