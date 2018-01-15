RSpec.describe GoogleCloudLoggingOnFork, type: :aruba do
  it 'run on spring' do
    run_simple 'rails new testapp'
    cd 'testapp'
    append_to_file 'Gemfile', <<-EOF
gem "google_cloud_logging_on_fork", :path => "../../.."
    EOF
    run_simple 'bundle install'
  end

  it "has a version number" do
    expect(GoogleCloudLoggingOnFork::VERSION).not_to be nil
  end
end
