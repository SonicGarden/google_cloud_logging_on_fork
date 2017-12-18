module GoogleCloudLoggingOnFork
  class Middleware
    def initialize(app, opts = {})
      @app = app
      @project_id = opts[:project_id]
    end

    def call(env)
      replace_logger
      original_middeware.call(env)
    end

    def original_middeware
      return @original_middeware if @original_middeware

      GoogleCloudLoggingOnFork.load(project_id)

      require 'google/cloud/logging/middleware'
      @original_middeware = Google::Cloud::Logging::Middleware.new(@app)
    end

    def replace_logger
      original_logger = Rails.logger
      if original_logger.is_a?(::ActiveSupport::Logger)
        Rails.logger = original_middeware.logger
        Rails.logger.extend(ActiveSupport::Logger.broadcast(original_logger))
      end
    end

    def project_id
      @project_id
    end
  end
end
