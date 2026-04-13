require_relative '../hello_world/version'

namespace :version do
  desc "Print the current app version"
  task :print do
    puts HelloWorld::VERSION
  end
end
