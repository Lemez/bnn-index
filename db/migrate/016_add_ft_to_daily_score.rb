class AddFtToDailyScore < ActiveRecord::Migration
  def self.up
    change_table :daily_scores do |t|
      t.float :ft
    end
  end

  def self.down
    change_table :daily_scores do |t|
      t.remove :ft
    end
  end
end
