include Rack::Utils
class PathInterpolator
  def self.path(options)
    params = options.with_indifferent_access
    params = parse_nested_query(options[:params]) if options[:params]
    return Appeal.find(params['appeal_id']).root_path.gsub(/appeal$/, 'reply') if params['appeal_id']
    return Appeal.find(params['id']).root_path if params['id']
    return "/appeals/#{params['section_id']}/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}/#{Time.now.hour}_#{Time.now.min}_#{UUID.generate.split('-').first}/#{params[:class_name]}" if params['section_id']
  end
end
