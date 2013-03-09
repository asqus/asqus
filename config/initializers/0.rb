# this should be the first of the initializers to be executed

PRIVATE_CONFIG = YAML.load_file(Rails.root.join( 'config','private','config.yml'))[Rails.env]