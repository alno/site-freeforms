# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class CheckDomain
  
  def self.call(env)
    if ENV['RAILS_ENV'] == 'production' && env["HTTP_HOST"] != APP_HOST
      [301, {"Location" => "http://#{APP_HOST}#{env["REQUEST_URI"]}"}, ["Found"]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
end
