class RemoveFieldsFromWords < ActiveRecord::Migration
  def self.up
    change_table :words do |t|
      t.remove :dictionary
    end
  end

  def self.down
    change_table :words do |t|
      t.string :dictionary
    end
  end
end
