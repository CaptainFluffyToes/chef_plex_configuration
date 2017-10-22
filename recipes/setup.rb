
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

#Create the directory used for the Media mount
directory 'Create directory for media' do
	path '/mnt/Media'
	action :create
	not_if { ::Dir.exist?("/mnt/Media") }	
end

#Mount the media share for access
mount 'Mount Media share for access' do
	device '//storage.solsys.com/Bucket/Media'
	fstype 'cifs'
	options 'rw,username=media_user,password=test'
	mount_point '/mnt/Media'
	action [:mount, :enable]
end