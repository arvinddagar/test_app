class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.string :value
      t.string :data_type
      t.timestamps
    end
    add_index :settings, :name, unique: true
  end
end