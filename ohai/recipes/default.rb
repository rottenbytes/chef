#
# Cookbook Name:: ohai
# Recipe:: default
#
# Copyright 2010, Opscode, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Ohai::Config[:plugin_path] << node.ohai.plugin_path
Chef::Log.debug("ohai plugins will be at: #{node.ohai.plugin_path}")

package "dmidecode" do
  action :nothing
end.run_action(:install)

if node[:platform] == 'debian' then
  debian_packages=[ "lsb-release" ]

  debian_packages.each do |pkg|
    package pkg do
      action :nothing
    end.run_action(:install)
  end
end

rd = remote_directory node.ohai.plugin_path do
  source 'plugins'
  owner 0
  group 0
  mode 0755
  action :nothing
  purge true
end

rd.run_action(:create)

o = Ohai::System.new
o.all_plugins
node.automatic_attrs.merge! o.data

