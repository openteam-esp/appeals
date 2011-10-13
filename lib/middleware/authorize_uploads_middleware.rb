class AuthorizeUploadsMiddleware
  def initialize(app, options={})
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] =~ %r{^/uploads/(\d+)/(.*)}
      throw(:warden) unless Ability.new.can? :read, Upload.where(:file_name => $2).find($1)
    end
    @app.call(env)
  end

end
