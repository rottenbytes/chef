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

Untested yet, meant to be used with mcollective.
