include Rack::Utils
class PathInterpolator
  def self.path(options)
    params = options.with_indifferent_access
    params = parse_nested_query(options[:params]) if options[:params]

    return Appeal.find(params['id']).root_path if params['id']
    return "/appeals/#{params['section_id']}/#{Time.now.year}_#{Time.now.month}_#{Time.now.day}_#{Time.now.hour}_#{Time.now.min}_#{UUID.generate.split('-').first}" if params['section_id']
  end
end
