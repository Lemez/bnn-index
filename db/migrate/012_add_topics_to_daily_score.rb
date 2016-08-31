class AddTopicsToDailyScore < ActiveRecord::Migration
  def self.up
    change_table :daily_scores do |t|
      t.text :topics
    end
  end

  def self.down
    change_table :daily_scores do |t|
      t.remove :topics
    end
  end
end
