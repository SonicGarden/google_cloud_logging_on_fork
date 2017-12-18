module GoogleCloudLoggingOnFork
  class Middleware
    def initialize app, opts = {}
      @app = app
      @project_id = opts[:project_id]
    end

    def call env
      original_middeware.call(env)
    end

    def original_middeware
      return @original_middeware if @original_middeware

      GoogleCloudLoggingOnFork.load(project_id)

      require 'google/cloud/logging/middleware'
      @original_middeware = Google::Cloud::Logging::Middleware.new(@app)
    end

    def project_id
      @project_id
    end
  end
end
