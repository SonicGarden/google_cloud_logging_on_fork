require "google_cloud_logging_on_fork/version"

module GoogleCloudLoggingOnFork
  def self.load(project_id = nil)
    if require 'google/cloud/logging'
      Google::Cloud::Logging.configure do |config|
        config.project_id = project_id || rails_config_project_id
        config.keyfile = rails_config_keyfile if rails_config_keyfile
        config.labels = rails_config_labels if rails_config_labels
      end
    end
  end

  def self.rails_config_project_id
    defined?(::Rails) && ::Rails.application.config.google_cloud_logging_on_fork.project_id
  end

  def self.rails_config_keyfile
    defined?(::Rails) && ::Rails.application.config.google_cloud_logging_on_fork.keyfile
  end

  def self.rails_config_labels
    defined?(::Rails) && ::Rails.application.config.google_cloud_logging_on_fork.labels
  end
end

if defined?(::Rails) && defined?(::Rails::Railtie)
  require 'google_cloud_logging_on_fork/railtie'
end
