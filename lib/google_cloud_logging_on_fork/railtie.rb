require 'google_cloud_logging_on_fork/middleware'

module GoogleCloudLoggingOnFork
  class Railtie < ::Rails::Railtie
    config.google_cloud_logging_on_fork = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging.monitored_resource = ::ActiveSupport::OrderedOptions.new
    config.google_cloud_logging_on_fork.logging.monitored_resource.labels = ::ActiveSupport::OrderedOptions.new

    initializer "GoogleCloudLoggingOnFork", before: :initialize_logger do |app|
      app.middleware.insert_before Rails::Rack::Logger, GoogleCloudLoggingOnFork::Middleware
      self.class.spring_after_fork
    end

    def self.spring_after_fork
      if defined?(::Spring)
        Spring.after_fork do
          GoogleCloudLoggingOnFork.load

          require 'google/cloud/logging/middleware'
          middleware = Google::Cloud::Logging::Middleware.new({})
          Rails.logger = middleware.logger
        end
      end
    end
  end
end
