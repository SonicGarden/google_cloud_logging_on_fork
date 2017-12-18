require "google_cloud_logging_on_fork/version"

module GoogleCloudLoggingOnFork
  def self.load(project_id = nil)
    require 'google/cloud/logging'
    Google::Cloud::Logging.configure do |config|
      config.project_id = project_id || rails_conf_project_id
    end
  end

  def self.rails_conf_project_id
    defined?(::Rails) && ::Rails.application.config.google_cloud_logging_on_fork.project_id
  end
end

if defined?(::Rails) && defined?(::Rails::Railtie)
  require 'google_cloud_logging_on_fork/railtie'
end
