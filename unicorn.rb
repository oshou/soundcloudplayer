@appname="scp"

worker_processes  1
working_directory "/usr/local/src/ruby/scp/"
listen "/tmp/sockets/app_scp.sock"
pid "/var/run/unicorn_"+ @appname + ".pid"
stdout_path "/var/log/unicorn/unicorn_" + @appname + "_stdout.log"
stderr_path "/var/log/unicorn/unicorn_" + @appname + "_stderr.log"
preload_app true
timeout 300
