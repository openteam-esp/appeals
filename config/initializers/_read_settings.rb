Settings.read(Rails.root.join('config', 'settings.yml'))

Settings.defaults Settings.extract!(Rails.env)[Rails.env] || {}
Settings.extract!(:test, :development, :production)

Settings.define 'hoptoad.api_key',            :env_var => 'HOPTOAD_API_KEY'
Settings.define 'hoptoad.host',               :env_var => 'HOPTOAD_HOST'

Settings.define 'el_vfs.protocol',            :env_var => 'EL_VFS_PROTOCOL'
Settings.define 'el_vfs.host',                :env_var => 'EL_VFS_HOST'
Settings.define 'el_vfs.port',                :env_var => 'EL_VFS_POST'

Settings.define 'sso_provider.host',          :env_var => 'SSO_PROVIDER_HOST'

Settings.resolve!
