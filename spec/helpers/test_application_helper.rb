class TestApplication
  def call(env)
    code   = 200
    body   = [ "test body" ]
    header = { "Content-Type"           => "text/html;charset=utf-8",
               "Content-Length"         => "9",
               "X-XSS-Protection"       => "1; mode=block",
               "X-Content-Type-Options" => "nosniff",
               "X-Frame-Options"        => "SAMEORIGIN" }

    # puts env
    # binding.pry
    @logger = env['rack.logger']
    @logger.info "[Test Log] #{Time.now}"
    [code, header, body]
  end

  attr_reader :logger
end
