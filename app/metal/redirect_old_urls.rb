# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class RedirectOldUrls

  def self.call(env)
    if Rails.env == 'production' && env["HTTP_HOST"] != APP_HOST
      [301, {"Location" => "http://#{APP_HOST}#{env["REQUEST_URI"]}"}, ["Found"]]
    elsif env["REQUEST_URI"] =~  /^\/(\d+)\.(\w+)$/
      [301, {"Location" => "http://#{APP_HOST}/forms/#{$1}/code.#{$2}"}, ["Found"]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end

end
