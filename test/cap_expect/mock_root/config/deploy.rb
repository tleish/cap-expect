set :application, "my app"
set :gateway, "1.2.3.4:22"
set :branch, "master"
set :root_path, "/this/is"
set :deploy_to, "#{root_path}/my/path"
set :repository,  "set your repository location here"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, "web-server"                          # Your HTTP server, Apache/etc
role :app, "server-app1", "server-app2",
     "server-app3", "server-app4"

role :db,  "db-server", :primary => true # This is where Rails migrations will run
role :db,  "db-server"
