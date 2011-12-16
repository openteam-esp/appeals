include Rack::Utils

class PathInterpolator

  def self.path(request)
    options = request.params
    params = options.with_indifferent_access
    params = parse_nested_query(options[:params]) if options[:params]
    return Appeal.find(params[:appeal_id]).root_path.gsub(/appeal$/, 'reply') if params[:appeal_id]
    return Appeal.find(params[:id]).root_path if params[:id]
    if params[:section_id]
      request.session[:appeal_attachemnts_path] ||= {}
      request.session[:appeal_attachemnts_path][params[:section_id]] ||= generate_path(params)
    end
  end

  def self.generate_path(params)
    "/appeals/#{params[:section_id]}/#{Time.now.strftime('%Y/%m/%d/%H_%M')}_#{SecureRandom.hex(4)}/#{params[:class_name]}"
  end

end
