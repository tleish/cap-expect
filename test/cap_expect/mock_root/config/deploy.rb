set :application, "my app"
set :gateway, "1.2.3.4:22"
set :branch, "master"
set :deploy_to, "/this/is/my/path"
set :repository,  "set your repository location here"

role :web, "web-server"                          # Your HTTP server, Apache/etc
role :app, "server-app1", "server-app2",
     "server-app3", "server-app4"

role :db,  "db-server", :primary => true # This is where Rails migrations will run
role :db,  "db-server"
