rails_root = File.expand_path("../../", __FILE__)

# ワーカー数を定義
worker_processes 2
preload_app true
working_directory rails_root
timeout 60
# nginxを使用するための設定
listen File.expand_path("../../tmp/sockets/unicorn.sock", __FILE__)

pid File.expand_path("../../tmp/pids/unicorn.pid", __FILE__)

# Unicornのエラーログと通常ログの位置を指定
stderr_path File.expand_path("log/unicorn.stderr.log", rails_root)
stdout_path File.expand_path("log/unicorn.stdout.log", rails_root)

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end