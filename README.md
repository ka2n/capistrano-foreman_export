# Capistrano::ForemanExport

Capistrano task for foreman. Supervisord is supported.
Export supervisord configuration from Procfile using `foreman export`. 

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-foreman_export'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-foreman_export


## Usage

Add this line to your `Capfile`:

    require 'capistrano/foreman_export'

If you want to restart the application after deploy, add this line to your `config/deploy.rb`:

    after 'deploy', 'foreman:export'
    after 'deploy', 'foreman:restart'

Configurable options:

    set :foreman_backend, Capistrano::ForemanExport::Backend::Supervisord
    set :foreman_roles, :app
    set :foreman_port, 5000
    set :foreman_output, '/etc/supervisor.d'
    set :foreman_root, -> { release_path }
    set :foreman_app, -> { fetch(:application) }
    set :foreman_procfile, -> { release_path.join('Procfile') }
    set :foreman_log, -> { release_path.join('log') }
    set :foreman_user, 'nginx'
    set :foreman_env_variables, { RAILS_ENV: 'development', FOO: 'Bar' }

This would be:

    $ cat /my_app/shared/RUNTIME_ENV
    RAILS_ENV=development
    FOO=Bar

    $ bundle exec foreman export supervisord /etc/supervisor.d \
    --port 5000 \
    --root /my_app/releases/201409081122 \
    --app my_app \
    --procfile /my_app/releases/201409081122/Procfile \
    --log /my_app/releases/201409081122/log \
    --env /my_app/shared/RUNTIME_ENV,/my_app/releases/201409081122/.env \
    --user nginx

### Environment Variables

    # This translates to SOME_ENV_VARIABLES=1 and save to RUNTIME_ENV file.
    set :foreman_env_variables, { some_env_variables: 1 }

## Capistrano Tasks

Export supervisord configuration from Procfile:

    cap foreman:export

(Restart|Start|Stop) the applications:

    cap foreman:(restart|start|stop)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
