require 'google_cloud_logging_on_fork/middleware'
require 'rack/test'

# ENV['LOGGING_KEYFILE_JSON'] に JSON 形式のキーファイルを入れて実行

RSpec.describe GoogleCloudLoggingOnFork::Middleware do
  include Rack::Test::Methods

  let(:app) { GoogleCloudLoggingOnFork::Middleware.new(test_app, project_id: 'mat-example') }

  context 'GET /hoge' do
    let(:test_app) { TestApplication.new }
    it 'should return 200 OK' do
      get '/hoge'

      expect(last_response.status).to eq 200

      expect(test_app.logger).to be_is_a(Google::Cloud::Logging::Logger)
    end
  end
end
