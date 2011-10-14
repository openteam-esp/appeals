class AuthorizeUploadsMiddleware
  def initialize(app, options={})
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] =~ %r{^/uploads/(\d+)/(.*)}
      upload = Upload.where(:file_name => Rack::Utils.unescape($2)).find($1)
      if upload.uploadable_id?
        throw(:warden) unless Ability.new.can? :read, upload
      else
        throw(:warden) unless [*env['rack.session'][:upload_ids]].include? upload.id
      end
    end
    @app.call(env)
  end

end
