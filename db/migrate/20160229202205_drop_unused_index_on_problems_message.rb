class DropUnusedIndexOnProblemsMessage < ActiveRecord::Migration[4.2]
  def up
    remove_index :problems, :message
  end

  def down
    add_index :problems, :message
  end
end
