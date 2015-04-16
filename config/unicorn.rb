# working_directory "/path/to/your/app"
working_directory "/home/framgia/capuchino"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/framgia/capuchino/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/framgia/capuchino/log/unicorn.log"
stdout_path "/home/framgia/capuchino/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.capuchino.sock"
listen "/tmp/unicorn.capuchino.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30