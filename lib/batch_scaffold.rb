require "batch_scaffold/version"

module BatchScaffold
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/scaffold.rake"
    end
  end
end
