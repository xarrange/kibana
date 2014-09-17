bash "kibana_download" do
    code <<-EOH
    wget #{node['kibana']['source']}
    tar -zxf "#{node['kibana']['file']}.tar.gz"
    mv "#{node['kibana']['file']}" "./#{node['kibana']['basedir']}/"
    rm -rf "#{node['kibana']['file']}.tar.gz"
    EOH
end

include_recipe "apache2"

file "#{node['apache']['dir']}/sites-enabled/kibana.conf" do
    content <<-EOH
    Listen 8080
    <VirtualHost *:8080>
    DocumentRoot /opt/kibana-3.1.0

    <Directory /opt/kibana-3.1.0>
	AllowOverride All
	Order allow,deny
        Allow from all
	Require all granted
    </Directory>
    </VirtualHost>
    EOH
    mode '640'
    action :create
    notifies :restart, "service[apache2]"
end
