include_recipe "apache2"

bash "kibana_download" do
	wget node['kibana']['source']
	tar -zxf "#{node['kibana']['file']}.tar.gz"
	mv "#{node['kibana']['file']}" node['kibana']['basedir']
	rm -rf "#{node['kibana']['file']}.tar.gz"
end

file "kibana_apache_conf" do
	path "#{node['apache']['dir']/kibana.conf"
	content "
	<VirtualHost *:#{node['kibana']['port']}>
	DocumentRoot #{node['kibana']['basedir']}/#{node['kibana']['file']}
	</VirtualHost>"

	mode '640'
	action :create
end

service "apache" do
  supports :restart => true, :reload => true
  action :enable
end