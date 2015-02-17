#
# Note that there is a Rails route to handle the pre-flight OPTIONS check
#

module CrossOriginResourceSharing
  extend ActiveSupport::Concern

  included do
    before_filter :cors_set_access_control_headers
  end

  # OPTIONS request

  def cors_preflight_check
    if request.method == 'OPTIONS'
      render :text => '', :content_type => 'text/plain'
    end
  end

  # Cross origin resource sharing

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Authorization'
    headers['Access-Control-Max-Age'] = '86400'
  end
end
