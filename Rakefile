# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

load 'tasks/emoji.rake'

Rake::Task[:default].clear if Rake::Task.task_defined?(:default)

namespace :spec do
  desc "Preparing test env"
  task :prepare do
    tmp_env = Rails.env
    Rails.env = "test"
    %w( errbit:copy_configs db:seed ).each do |task|
      Rake::Task[task].invoke
    end
    Rails.env = tmp_env
  end
end

Rake::Task["spec"].prerequisites << "spec:prepare"
task default: ['spec']
