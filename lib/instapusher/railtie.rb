require 'rails/engine'

module Instapusher
  class Engine < Rails::Engine

    rake_tasks do
      require 'instapusher/commands'

      desc "pushes to heroku"
      task :instapusher do
        Instapusher::Commands.deploy
      end
    end

  end
end
