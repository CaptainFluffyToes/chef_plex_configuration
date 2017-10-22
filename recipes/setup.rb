
#
# Cookbook:: plex_configuration
# Recipe:: setup
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#Update Apt for installation of CIFS
apt_update 'Updates Apt' do
	action :update
end

#Install CIFS for mounts
package 'Install CIFS' do
	package_name 'cifs-utils'
	action :install
end

dirs = ['/mnt/Media', '/mnt/Config', '/mnt/Temp']

dirs.each do |dir|
	directory "Create #{dir}" do
	  path "#{dir}"
	  action :create
	  not_if { ::Dir.exists?("#{dir}") }
	end
end

#Mount the media share for access
mount 'Mount Media share for access' do
	device '//storage.solsys.com/Bucket/Media'
	fstype 'cifs'
	options 'rw,username=media_user,password=test'
	mount_point '/mnt/Media'
	action [:mount, :enable]
end

#Mount the directory for temp transcoding
mount 'Mount temp transcoding directory' do
	device '//storage.solsys.com/Temp'
	fstype 'cifs'
	options 'rw,username=media_user,password=test'
	mount_point '/mnt/Temp'
	action [:mount]
  end