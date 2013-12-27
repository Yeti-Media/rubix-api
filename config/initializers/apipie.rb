Apipie.configure do |config|
  config.app_name                = "AnakinWebapp"
  config.api_base_url            = ""
  config.doc_base_url            = "/apidoc"
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
  config.validate                = false
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
