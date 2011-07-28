My chef related stuff
=====================

utils : nothing fancy, just tools
ohai : ohai stuff/plugins

License
=======

This stuff is under WTFPL. See http://sam.zoy.org/wtfpl/

The RAID ohai plugin
====================

Distribute it following : http://wiki.opscode.com/display/chef/Distributing+Ohai+Plugins
And then data is available under node[:raid][:devices] in your recipes.

The LSB ohai plugin
===================

Makes node[:lsb][:distcodename] available (tested under debian)

The Ohai report handler
=======================

Useless. Use the ohai fact source plugin from mcollective. left for educational purpose

The async report handler
========================

* async_handler.rb : the report handler itself.
* configfile.erb : the template for the configuration file of the report handler.
* recipe.rb : the deployment recipe, meant to be used with the opscode chef_handler cookbook.
* consumer.rb : simple queue consumer, drops to standard output.

