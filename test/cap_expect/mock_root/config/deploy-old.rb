set :application, "my app"
set :repository,  "repo"

role :web, "web-server"                          # Your HTTP server, Apache/etc
role :app, "app-server"                          # This may be the same as your `Web` server
