== FF Serv

Registration Server for the Freifunk Community Cologne/Frankfurt/Magdeburg.

=== Setup Application

we are right now working on branch ffm, which is a clone from branch v2.

```
gem install bundler
bundle install
```

=== DB Setup

```
su - postgres

initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'

createdb ff-serv
psql -d ff-serv

create role ffserv with login password 'auniquepassword';

gem install activerecord-postgresql-adapter
rake db:setup
```

Devise.secret_key was not set. Please add the following to your Devise initializer:

config/initializers/devise.rb:
* config.secret_key = '4409a5f74aed834a3484bd73d76108e81f6594777df0b0a54aae95d6b78f83b7b05d57e81cf3018ae127182fc07a1436d32106060957702da5a4c9da521ce31a'

Start server with:

```
rails server
```

=== Hardcoded Configuration

There are some hardcoded URLs in classes, these are:

```
index.html.erb --> https://register.ffm.freifunk.net
reset_password_instructions.html.erb --> Freifunk-FFM
nodes_reg.html.erb --> Freifunk-FFM-Node
map.html.erb --> Freifunk-FFM-Netz
unlock_instructions.html.erb --> Freifunk-FFM-Team, Freifunk-FFM-Account
confirmation_instructions.html.erb --> Freifunk-FFM-Team
node_registration/new.html.erb --> Freifunk-FFM-Node
_nodes_reg.html.erb --> Freifunk-FFM-Node
collision_info.text.erb --> ffm.freifunk.net-Team
collision_resolve.text.erb --> ffm.freifunk.net-Team, info@ffm.freifunk.net
tincs/index.html.erb --> info@ffm.freifunk.net
nodes_helper.rb --> https://ffm.freifunk.net/stats/ping/, http://stat.ffm.freifunk.net/nodes/#{node.mac.to_i(16)}/stats/ping.png, http://stat.ffm.freifunk.net/nodes/

javascripts/app.js --> http://stat.ffm.freifunk.net/nodes.json


tinc_mailer.rb --> info@ffm.freifunk.net, headers: X-KBU exchanged through X-FFM, default from info@ffm.freifunk.net)
production.rb --> https://register.ffm.freifunk.net
node.rb --> http://collectd.ffm.freifunk.net/nodes/add_macs --> the original (collectd.kbu.freifunk.net) seems to be not reachable

devise.rb --> register@ffm.freifunk.net

development.rb --> config.action_mailer.default_url_options = { :host => "127.0.0.1:3000" }

adopt config/collectd.yml.template (should be called collectd.yml)
adopt config/collectd_ping_hosts.conf.erb
```

