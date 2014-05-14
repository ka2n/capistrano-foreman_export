
module Capistrano
  module ForemanExport
    module Backend
      class Supervisord

        def name
          "supervisord"
        end

        def start_cmd(app_name)
          wrap_bash <<-CMD
          #{shell_add_if_new(app_name)}
          supervisorctl start #{app_name}:*
          CMD
        end

        def stop_cmd(app_name)
          wrap_bash <<-CMD
          supervisorctl stop #{app_name}:*
          CMD
        end

        def restart_cmd(app_name)
          wrap_bash <<-CMD
          #{shell_add_if_new(app_name)}
          supervisorctl restart #{app_name}:*
          CMD
        end

        def shell_add_if_new(app_name)
          "supervisorctl reread;  sleep 3; supervisorctl status | grep -w -- '#{app_name}' | grep -qv grep || supervisorctl add #{app_name}"
        end

        def wrap_bash(cmd)
          "/bin/bash -c \"#{undent(cmd)}\""
        end

        def undent(str)
          # from https://github.com/msmorgan/homebrew/blob/master/Library/Homebrew/extend/string.rb
          str.gsub(/^.{#{str.slice(/^ +/).length}}/, '')
        end
      end
    end
  end
end
