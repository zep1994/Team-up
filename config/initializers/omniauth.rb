Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'c02f8e87c69938782f45', '5539dd9760097a4f1ecf8d8ed8d07c58f639b558'
end
