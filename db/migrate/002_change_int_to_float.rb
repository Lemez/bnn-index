class ChangeIntToFloat < ActiveRecord::Migration
  def self.up
  	 change_column :scores, :score, :float
  end

  def self.down
  	change_column :scores, :score, :integer
  end
end
