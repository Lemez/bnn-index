class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string :lemma
      t.integer :storyid
      t.integer :score
      t.string :dictionary
      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end
