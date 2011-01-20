#
# Cookbook Name:: nova
# Recipe:: hostname
#
# Copyright 2011, Anso Labs
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

domain = node[:fqdn].split('.')[1..-1].join('.')

execute "/root/hostname.sh" do
  action :nothing
end

template "/root/hostname.sh" do
  source "hostname.erb"
  owner "root"
  group "root"
  mode 0755
  variables(
    :ip => node[:nova][:my_ip],
    :hostname => node.name.nil? || node.name.empty? ? node[:nova][:hostname] : node.name,
    :domain => domain
  )
  notifies :run, resources(:execute => "/root/hostname.sh"), :immediately
end
