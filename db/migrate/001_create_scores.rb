class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.datetime :date
      t.integer :score
      t.string :source
      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
