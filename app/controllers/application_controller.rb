class ApplicationController < ActionController::API

    include CrossOriginResourceSharing

  before_filter :set_access_control_headers

def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Authorization'
    headers['Access-Control-Max-Age'] = '86400'
  end

end