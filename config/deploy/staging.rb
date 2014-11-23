# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
#role :app, %w{deploy@example.com}
role :app, %w{asr-web-dev4.oit.umn.edu}
role :web, %w{asr-web-dev4.oit.umn.edu}

# Configuration
set :user, 'asrwebteam'
set :server, 'asr-web-dev4.oit.umn.edu'
set :roles, %w{web app}
set :web_root, '/swadm/www/apps-test.asr.umn.edu'

# Authenticating with a UMN server
# ======================
# Mkey authenticaton fails randomly with Capistrano 3. You'll need to be set up to connect to the server with your public SSH key.
# http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/

server 'asr-web-dev4.oit.umn.edu',
  roles: fetch(:roles),
  web_root: fetch(:web_root),
  ssh_options: {
    user: fetch(:user),
    forward_agent: true,
    auth_methods: %w(publickey)}
