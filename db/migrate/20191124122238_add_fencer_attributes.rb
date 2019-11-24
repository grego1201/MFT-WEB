class AddFencerAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :fencers, :handness, :integer
    add_column :fencers, :weapon, :integer
    add_column :fencers, :ranking, :integer
  end
end
