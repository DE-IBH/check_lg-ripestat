check_lg-ripestat - monitoring AS announcement visibility using looking glass API of RIPEstat
=============================================================================================

About
-----

This nagios plugin monitors the announcements, AS path counts and AS peerings
using RIPEstat[1]. RIPEstat provides an JSON API to access informations about
Autonomous System (AS) including the Routing Information Service (RIS)[2].

- [1] https://stat.ripe.net/index/about-ripestat
- [2] https://www.ripe.net/analyse/internet-measurements/routing-information-service-ris/routing-information-service-ris


Install
-------

*check_lg-ripestat* is implemented in *Perl* and depends on the following *Perl* modules:
- Nagios::Plugin
- HTTP::Request::Common
- LWP::UserAgent
- JSON
- URI

To install those modules on *Debian GNU/Linux*:

```console
# apt-get install libnagios-plugin-perl libwww-perl libjson-perl liburi-perl
```

Usage
-----

You need to define a command for *check_lg-ripestat*:

`command.cfg`
```
define command {
  command_name    check_lg-ripestat
  /usr/local/lib/nagios/plugins/check_lg-ripestat --extra-opts=$ARG1$ --prefix=$ARG2$
}
```

`plugins.ini`
```ini
[AS15372]
asn=15372
peerings=3320,13237,20676
pw=100
pc=80
```

The options can be provided as parameters or within a configuration file using
the *--extra-opts* parameter[3].

- [3] http://nagios-plugins.org/doc/extra-opts.html


For each prefix announcement to be monitored you need to define an approperiate
service:

`services.cfg`
```
define service {
  host_name                     BGP-LookingGlass
  service_description           AS15372 IBH 212.111.224.0/19
  check_command                 check_lg-ripestat!AS15372!212.111.224.0/19
  check_interval                60.0
}
```
