class RemoveAfinnMixedWiebeFromScores < ActiveRecord::Migration
  def self.up
    change_table :scores do |t|
      t.remove :afinn
      t.remove :wiebe
      t.remove :mixed
    end
  end

  def self.down
    change_table :scores do |t|
      t.float :afinn
      t.float :mixed
      t.float :wiebe
    end
  end
end
