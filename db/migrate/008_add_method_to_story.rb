class AddMethodToStory < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.string :method
    end
  end

  def self.down
    change_table :stories do |t|
      t.remove :method
    end
  end
end
