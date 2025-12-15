require 'yaml'

puts YAML.safe_load File.read('object.yaml')
