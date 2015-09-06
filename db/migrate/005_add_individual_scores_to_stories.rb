class AddIndividualScoresToStories < ActiveRecord::Migration
  def self.up
  	add_column :stories, :afinn, :float
  	add_column :stories, :wiebe, :float
  	rename_column :stories, :score, :mixed
  end

  def self.down
  	remove_column :stories, :afinn, :float
  	remove_column :stories, :wiebe, :float
  	rename_column :stories, :mixed, :score
  end
end
