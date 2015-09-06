class AddIndividualScoresToScore < ActiveRecord::Migration
  def self.up
  	add_column :scores, :afinn, :float
  	add_column :scores, :wiebe, :float
  	add_column :scores, :mixed, :float
  end

  def self.down
  	remove_column :scores, :afinn
  	remove_column :scores, :wiebe
  	remove_column :scores, :mixed
  end
end
