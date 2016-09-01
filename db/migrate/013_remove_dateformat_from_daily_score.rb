class RemoveDateformatFromDailyScore < ActiveRecord::Migration
   def self.up
    change_table :daily_scores do |t|
      t.remove :dateformat
      t.remove :times
    end
  end

  def self.down
    change_table :daily_scores do |t|
      t.text :dateformat
      t.float :times
    end
  end
end
