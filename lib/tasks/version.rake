require_relative '../hello_world/version'

VERSION_FILE = File.expand_path('../hello_world/version.rb', __dir__)

def bump_semver(version, part)
  major, minor, patch = version.split('.').map(&:to_i)

  case part
  when 'major'
    [major + 1, 0, 0]
  when 'minor'
    [major, minor + 1, 0]
  when 'patch'
    [major, minor, patch + 1]
  else
    raise ArgumentError, "Invalid part '#{part}'. Use major, minor, or patch"
  end.join('.')
end

namespace :version do
  desc "Print the current app version"
  task :print do
    puts HelloWorld::VERSION
  end

  desc "Print release version without SNAPSHOT suffix"
  task :release do
    puts HelloWorld::VERSION.sub(/-SNAPSHOT\z/, '')
  end

  desc "Bump semantic version and set SNAPSHOT suffix (usage: rake \"version:bump[patch]\")"
  task :bump, [:part] do |_task, args|
    part = (args[:part] || 'patch').to_s
    current = HelloWorld::VERSION.sub(/-SNAPSHOT\z/, '')
    next_version = "#{bump_semver(current, part)}-SNAPSHOT"

    content = File.read(VERSION_FILE)
    updated = content.sub(/(STRING\s*=\s*['"]).*?(['"])/, "\\1#{next_version}\\2")
    File.write(VERSION_FILE, updated)

    puts next_version
  end

  desc "Prepare the next patch snapshot version"
  task :prepare_next do
    Rake::Task['version:bump'].invoke('patch')
  end
end
