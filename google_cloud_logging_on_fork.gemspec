lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google_cloud_logging_on_fork/version"

Gem::Specification.new do |spec|
  spec.name          = "google_cloud_logging_on_fork"
  spec.version       = GoogleCloudLoggingOnFork::VERSION
  spec.authors       = ["Akihiro MATSUMURA"]
  spec.email         = ["matsumura.aki@gmail.com"]

  spec.summary       = %q{Google::Cloud::Logging wrapper for middleware using fork like Passenger, Spring}
  spec.description   = %q{Grpc does not work on middleware using fork}
  spec.homepage      = 'https://github.com/mataki/'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "google-cloud-logging", "~> 1.3"

  spec.add_development_dependency "rails"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "appraisal"
end
