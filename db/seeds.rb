# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |t|
  User.create(
    email: "test#{t}@example.com",
    password: "password",
    password_confirmation: "password",
    role: 1
  )
end

10.times do |t|
  User.create(
    email: "sample#{t}@example.com",
    password: "password",
    password_confirmation: "password",
    role: 0
  )
end

Category.create(name: "政治")
Category.create(name: "テクノロジー")
Category.create(name: "金融")
Category.create(name: "新型コロナ")
Category.create(name: "プログラミング")

20.times do |t|
  Article.create(
    user_id: rand(1..10),
    category_id: rand(1..5),
    title: "テストタイトル#{t}",
    content: "テスト本文",
    slug: "test#{t}",
    status: 1,
    released_at: Time.zone.now.tomorrow,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

20.times do |t|
  Article.create(
    user_id: rand(1..10),
    category_id: rand(1..5),
    title: "プログラムタイトル#{t}",
    content: "プログラム本文",
    slug: "program#{t}",
    status: 1,
    pv_count: rand(0..1000),
    released_at: Time.zone.local(2019, 11, 1, 10, 00),
    created_at: Time.zone.local(2019, 10, 30, 10, 00),
    updated_at: Time.zone.local(2019, 10, 30, 10, 00)
  )
end

20.times do |t|
  Article.create(
    user_id: rand(1..10),
    category_id: rand(1..5),
    title: "サンプルタイトル#{t}",
    content: "サンプル本文",
    slug: "sample#{t}",
    status: 0
  )
end

50.times do |t|
  Comment.create(
    article_id: rand(21..40),
    comment: "コメント",
    created_at: Time.zone.local(2019, 10, 31, 10, 00),
    updated_at: Time.zone.local(2019, 10, 31, 10, 00)
  )
end

30.times do |time|
  50.times do |t|
    Comment.create(
      article_id: rand(21..40),
      comment: "コメント",
      created_at: Time.zone.local(2019, 11, time + 1, 10, 00),
      updated_at: Time.zone.local(2019, 11, time + 1, 10, 00)
    )
  end
end

20.times do |t|
  t += 21
  comment = Comment.where(article_id: t).where(created_at: Time.zone.local(2019, 10, 31, 10, 00))
  DailyArticleSummary.create(
    article_id: t,
    pv_count: rand(1..1000),
    comment_count: comment.size,
    date: Date.new(2019, 10, 31),
    created_at: Time.zone.local(2019, 11, 1, 10, 00),
    updated_at: Time.zone.local(2019, 11, 1, 10, 00)
  )
end

20.times do |time|
  time += 21
  29.times do |t|
    comments = Comment.where(article_id: time).where(created_at: Time.zone.local(2019, 11, t + 1, 10, 00))
    DailyArticleSummary.create(
      article_id: time,
      pv_count: rand(1..1000),
      comment_count: comments.size,
      date: Date.new(2019, 11, t + 1),
      created_at: Time.zone.local(2019, 11, t + 2, 10, 00),
      updated_at: Time.zone.local(2019, 11, t + 2, 10, 00)
    )
  end

  comments = Comment.where(article_id: time).where(created_at: Time.zone.local(2019, 11, 30, 10, 00))
  DailyArticleSummary.create(
    article_id: time,
    pv_count: rand(1..1000),
    comment_count: comments.size,
    date: Date.new(2019, 11, 30),
    created_at: Time.zone.local(2019, 12, 1, 10, 00),
    updated_at: Time.zone.local(2019, 12, 1, 10, 00)
  )
end

20.times do |time|
  time += 21
  30.times do |t|
    comments = Comment.where(article_id: time).where(created_at: Time.zone.local(2019, 12, t + 1, 10, 00))
    DailyArticleSummary.create(
      article_id: time,
      pv_count: rand(1..1000),
      comment_count: comments.size,
      date: Date.new(2019, 12, t + 1),
      created_at: Time.zone.local(2019, 12, t + 2, 10, 00),
      updated_at: Time.zone.local(2019, 12, t + 2, 10, 00)
    )
  end
end