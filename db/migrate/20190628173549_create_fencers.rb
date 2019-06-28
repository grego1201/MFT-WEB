class CreateFencers < ActiveRecord::Migration[5.2]
  def change
    create_table :fencers do |t|

      t.string :name
      t.integer :height
      t.integer :age
      t.boolean :intimidated
      t.integer :grip

      t.timestamps
    end
  end
end
