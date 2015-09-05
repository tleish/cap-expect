require "bundler/gem_tasks"

task :install do
  system "gem build cap-expect.gemspec"
  system "gem install ./cap-expect-#{CapExpect::VERSION}.gem"
end