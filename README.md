check_lg-ripestat - monitoring AS announcement visibility using looking glass API of RIPEstat
=============================================================================================

About
-----

This nagios plugin monitors the announcements, AS path counts and AS peerings
using [RIPEstat](https://stat.ripe.net/index/about-ripestat). RIPEstat provides an JSON API to access informations about
Autonomous System (AS) including the [Routing Information Service](https://www.ripe.net/analyse/internet-measurements/routing-information-service-ris/routing-information-service-ris) (RIS).


Install
-------

*check_lg-ripestat* is implemented in *Perl* and depends on the following *Perl* modules:
- Monitoring::Plugin
- HTTP::Request::Common
- LWP::UserAgent
- JSON
- URI

To install those modules on *Debian GNU/Linux*:

```console
# apt-get install libmonitoring-plugin-perl libwww-perl libjson-perl liburi-perl
```

Usage
-----

```console
check_lg-ripestat (--asn=<aut-num>,...) (--prefix=<prefix>) (--peerings=<aut-num>,...) [-c|--criticals=<threshold>] [-w|--warnings=<threshold>] ...

 -?, --usage
   Print usage information
 -h, --help
   Print detailed help screen
 -V, --version
   Print version information
 --extra-opts=[section][@file]
   Read options from an ini file. See http://nagiosplugins.org/extra-opts
   for usage and examples.
 --asn=INTEGER[,INTEGER]*
   Origin AS number(s) to check
 --prefix=PREFIX
   IP prefix to query
 --peerings=ASN[,ASN]*
   Allowed peering ASNs
 -w, --warnings=INTEGER:INTEGER[,INTEGER:INTEGER]*
   Path count warning thresholds for each peer
 -c, --criticals=INTEGER:INTEGER[,INTEGER:INTEGER]*
   Path count critical thresholds for each peer
 --pw=INTEGER:INTEGER
   Path count warning thresholds over all peers
 --pc=INTEGER:INTEGER
   Path count critical thresholds over all peers
 --ignoressl
   Ignore bad ssl certificates
 -t, --timeout=INTEGER
   Seconds before plugin times out (default: 15)
 -v, --verbose
   Show details for command-line debugging (can repeat up to 3 times)
```


Nagios
------

You need to define a command for *check_lg-ripestat*:

**command.cfg**
```
define command {
  command_name    check_lg-ripestat
  /usr/local/lib/nagios/plugins/check_lg-ripestat --extra-opts=$ARG1$ --prefix=$ARG2$
}
```

**plugins.ini**
```ini
[AS15372]
asn=15372
peerings=3320,13237,20676
pw=100:
pc=80:
```

The options can be provided as parameters or within a configuration file using
the [*--extra-opts* parameter](http://nagios-plugins.org/doc/extra-opts.html).

For each prefix announcement to be monitored you need to define an approperiate
service:

**services.cfg**
```
define service {
  host_name                     BGP-LookingGlass
  service_description           AS15372 IBH 212.111.224.0/19
  check_command                 check_lg-ripestat!AS15372!212.111.224.0/19
  check_interval                60.0
}
```

### WATO

In *Check_MK* the plugin can be used as a *Classical active and passive
Monitoring check*:

![WATO][screenshot]

[screenshot]: wato.jpg
