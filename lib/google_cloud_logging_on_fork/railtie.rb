require 'google_cloud_logging_on_fork/middleware'

module GoogleCloudLoggingOnFork
  class Railtie < ::Rails::Railtie
    config.google_cloud_logging_on_fork = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging.monitored_resource = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging.monitored_resource.labels = ::ActiveSupport::OrderedOptions.new

    initializer "GoogleCloudLoggingOnFork", before: :initialize_logger do |app|
      if ::Rails.application.config.google_cloud_logging_on_fork.project_id
        app.middleware.insert_before Rails::Rack::Logger, GoogleCloudLoggingOnFork::Middleware, logger: self.class.logger
        self.class.spring_after_fork
      else
        puts "[GoogleCloudLoggingOnFork] Not initialized, project_id is blank."
      end
    end

    def self.spring_after_fork
      if defined?(::Spring)
        Spring.after_fork do
          GoogleCloudLoggingOnFork.load

          Rails.logger = self.logger
        end
      end
    end

    def self.logger
      require 'google/cloud/logging'
      require 'google/cloud/logging/middleware'
      logging = Google::Cloud::Logging.new project: config.project_id, keyfile: config.keyfile

      resource = Google::Cloud::Logging::Middleware.build_monitored_resource
      log_name = config.log_name || Google::Cloud::Logging::Middleware::DEFAULT_LOG_NAME
      logging.logger log_name, resource, config.labels
    end

    def self.config
      ::Rails.application.config.google_cloud_logging_on_fork
    end
  end
end
