class NormalizeHashesForUserAttributesAndCurrentUser < ActiveRecord::Migration[5.0]
  def up
    execute <<~SQL
      UPDATE notices
      SET user_attributes = replace(user_attributes, '--- !ruby/hash:ActionController::Parameters', '---')
      WHERE user_attributes LIKE '--- !ruby/hash:ActionController::Parameters%';
    SQL

    execute <<~SQL
      UPDATE notices
      SET "current_user" = replace("current_user", '--- !ruby/hash:ActionController::Parameters', '---')
      WHERE "current_user" LIKE '--- !ruby/hash:ActionController::Parameters%';
    SQL
  end
end
