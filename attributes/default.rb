
default['kibana']['version'] = '3.1.0'
default['kibana']['file'] = "kibana-#{node['kibana']['version']}"
default['kibana']['source'] = "https://download.elasticsearch.org/kibana/kibana/#{node['kibana']['file']}.tar.gz"
default['kibana']['basedir'] = '/opt'
default['kibana']['port'] = '8080'

