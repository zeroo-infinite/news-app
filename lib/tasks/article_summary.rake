namespace :article_summary do
  desc "日別、週間、月間のpv数とコメント数を記事毎で集計"
  task summary: :environment do
    CreateArticleSummaryWorker.perform_async
  end
end