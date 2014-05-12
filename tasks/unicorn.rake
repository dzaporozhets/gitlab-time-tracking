desc "Run unicorn web server"
task :unicorn => ["unicorn:development"]

namespace :unicorn do
  desc "Run unicorn web server for development"
  task :development do
    system "unicorn -c config/unicorn.rb -E development -p 4567"
  end

  desc "Run unicorn web server for production"
  task :production do
    system "unicorn -c config/unicorn.rb -E production -D"
  end
end
