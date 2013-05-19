if Rails.env != "production"
  LINKEDIN_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/linkedin.yml")[Rails.env]
  ENV['LINKEDIN_API_KEY'] = LINKEDIN_CONFIG["api_key"]
  ENV['LINKEDIN_SECRET']  = LINKEDIN_CONFIG["secret"]
end
