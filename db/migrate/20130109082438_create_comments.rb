class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :problem_id
      t.text :body

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :problem_id
  end
end
