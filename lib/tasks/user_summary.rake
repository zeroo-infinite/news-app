namespace :user_summary do
  desc "日別、週間、月間のpv数とコメント数をユーザ毎で集計"
  task :summary do
    CreateUserSummaryWorker.perform_async
  end
end