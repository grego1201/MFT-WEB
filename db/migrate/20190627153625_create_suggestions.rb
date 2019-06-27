class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|

      t.string :username
      t.text :suggest

      t.timestamps
    end
  end
end
