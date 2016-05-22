class CreateDailyScores < ActiveRecord::Migration
  def self.up
    create_table :daily_scores do |t|
      t.float :average
      t.datetime :date
      t.float :express
      t.float :independent
      t.float :guardian
      t.float :telegraph
      t.float :mail
      t.float :times
      t.timestamps
    end
  end

  def self.down
    drop_table :daily_scores
  end
end
