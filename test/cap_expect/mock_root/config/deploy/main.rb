set :application, "my app"
set :gateway, "1.2.3.4:22"
set :branch, "master"
set :deploy_to, "/this/is/my/path"
set :repository,  "set your repository location here"
set :user, 'test'

server 'server-app1', user: fetch(:user), roles: %w{app}, primary: true
server 'server-app2', user: fetch(:user), roles: %w{app}
server 'server-app3', user: fetch(:user), roles: %w{app}
server 'server-app4', user: fetch(:user), roles: %w{app}
server 'db-server', user: fetch(:user), roles: %w{db}
server 'web-server', user: fetch(:user), roles: %w{web}