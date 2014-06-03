

module Capistrano
  module ForemanExport
    module Backend
      class Supervisord

        def initialize(task)
          @task = task
        end

        def name
          "supervisord"
        end

        def app_name
          @task.fetch(:foreman_app)
        end

        def start_cmd
          add_or_update_app
          @task.execute(:sudo, "supervisorctl start #{app_name}:*")
        end

        def stop_cmd
          @task.execute(:sudo, "supervisorctl stop #{app_name}:*")
        end

        def restart_cmd
          add_or_update_app
          @task.execute(:sudo, "supervisorctl restart #{app_name}:*")
        end

        def add_or_update_app
          status = supervisord_reread
          if status.include?("#{app_name}:")
            if status.include('available')
              @task.info("Configration available, add it.")
              @task.execute(:sudo, "supervisorctl add #{app_name}")
            end
          end
        end

        def supervisord_reread
          @task.capture(:sudo, %{supervisorctl reread})
        end
      end
    end
  end
end
