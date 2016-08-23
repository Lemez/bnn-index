class AddFieldsToWords < ActiveRecord::Migration
  def self.up
    change_table :words do |t|
      t.boolean :afinn
    t.boolean :wiebe
    t.boolean :jonlist
    end
  end

  def self.down
    change_table :words do |t|
      t.remove :afinn
    t.remove :wiebe
    t.remove :jonlist
    end
  end
end
