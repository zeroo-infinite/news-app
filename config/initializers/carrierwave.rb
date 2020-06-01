CarrierWave.configure do |config|
  if Rails.env.production?
    aws_conf = Settings.fog_storage.aws
    config.fog_credentials = {
      provider:  "AWS",
      aws_access_key_id: aws_conf.access_key,
      aws_secret_access_key: aws_conf.secret_access_key,
      region: "ap-northeast-1"
    }
    config.fog_directory  = "news-application-s3"
  end
end