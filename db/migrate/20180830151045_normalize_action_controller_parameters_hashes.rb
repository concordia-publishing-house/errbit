class NormalizeActionControllerParametersHashes < ActiveRecord::Migration[5.0]

  def up
    migrate_attribute! :user_attributes
    migrate_attribute! :current_user
  end

private

  def migrate_attribute!(attribute)
    Notice.where("#{attribute} LIKE '--- !ruby/hash-with-ivars:ActionController::Parameters%'").pluck(:id, "#{attribute} \"x\"").each do |id, yaml|
      adjusted_yaml = "---\n" + yaml[/^elements:\n(.*)^ivars:\n/m, 1]
      parsed_yaml = parse_yaml(adjusted_yaml)
      Notice.where(id: id).update_all(attribute => parsed_yaml)
    end
  end

  def parse_yaml(yaml)
    ActiveRecord::Coders::YAMLColumn.new(Hash).load(yaml)
  end

end
