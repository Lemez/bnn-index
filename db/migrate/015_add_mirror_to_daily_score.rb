class AddMirrorToDailyScore < ActiveRecord::Migration
  def self.up
    change_table :daily_scores do |t|
      t.float :mirror
    end
  end

  def self.down
    change_table :daily_scores do |t|
      t.remove :mirror
    end
  end
end
