class AddDateformatToDailyScores < ActiveRecord::Migration
  def self.up
    change_table :daily_scores do |t|
      t.date :dateformat
    end
  end

  def self.down
    change_table :daily_scores do |t|
      t.remove :dateformat
    end
  end
end
