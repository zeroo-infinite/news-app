Config.setup do |config|
  # デフォルトでは下記のリストの順番でコンパイルされるため、リストの下位で定義した設定は上位の設定を上書きできる
  # config/settings.yml
  # config/settings/#{environment}.yml
  # config/environments/#{environment}.yml
  # config/settings.local.yml
  # config/settings/#{environment}.local.yml
  # config/environments/#{environment}.local.yml

  # Name of the constant exposing loaded settings
  config.const_name = 'Settings'

  # Define ENV variable prefix deciding which variables to load into config.
  #
  # Reading variables from ENV is case-sensitive. If you define lowercase value below, ensure your ENV variables are
  # prefixed in the same way.
  #
  # When not set it defaults to `config.const_name`.
  #
  config.env_prefix = 'SETTINGS'
end
