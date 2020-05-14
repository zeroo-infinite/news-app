namespace :unicorn do
  desc "unicornの起動"
  task :start do
    config =  rails_root + "/config/unicorn.rb"
    sh "bundle exec unicorn -c #{config} -D"
  end

  desc "unicornの停止"
  task(:stop) { unicorn_signal :QUIT }

  desc "unicornの再起動"
  task(:restart) { unicorn_signal :USR2 }

  desc "worker process数を増やす"
  task(:increment) { unicorn_signal :TTIN }

  desc "worker process数を減らす"
  task(:decrement) { unicorn_signal :TTOU }

  def unicorn_signal signal
    Process.kill(signal, unicorn_pid)
  end

  def unicorn_pid
    # ここresucueさせる必要あるのか？
    File.read("/var/run/server.pid").to_i
  end

  def rails_root
    File.expand_path("../../../", __FILE__)
  end
end