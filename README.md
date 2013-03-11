#puppet-logstash
- - - 

A module to install and configure logstash.

This is for Debian/Ubuntu.

###Usage

Download the latest monolithic .jar file from [Logstash's website](http://logstash.net/). Place it in the `files/` folder of the module and rename it to `logstash.jar`.

In the **Variables** section at the top of `init.pp`, you can specify values for several things but the only one you should really check is the location of your machine's Java runtime binary (usually at `/usr/bin/java`). 

In your `site.pp`, apply the `logstash` class to a node (see below if you want to specify parameters):

<pre>
node 'logstash-server' {
    include logstash
}
</pre>

####Parameters

This module exposes the following parameters. Specifying these isn't absolutely necessary, as the parameters have reasonable defaults set:


* `config_file_path`: The path for the `.conf` file Logstash wil load. Defaults to `/etc/logstash/central.conf`.
* `logstash_log_path`: The path for the logfile that Logstash will log its own events to. Defaults to `/var/log/logstash/logstash.log`.
* `java_runtime_path`: The path to the Java runtime binary. Defaults to `/usr/bin/java`
* `jar_file_path`: The path where the Logstash monolithic .jar file will be placed and run from. Defaults to `/opt/logstash/logstash.jar`.
* `logstash_version`: The version of Logstash you want to download and install.

If you wanted to change the parameters, a node definition with the parameterized class would look like this:

<pre>
node 'logstash-server' {

  class {'logstash':
    config_file_path   => '/etc/logstash/central.conf',
    logstash_log_path  => '/var/log/logstash/logstash.log',
    java_runtime_path  => '/usr/bin/java',
    jar_file_path      => '/opt/logstash/logstash.jar'
  }

}
</pre> 

###Contributions

* [rtd](https://github.com/rtd) for their init.d script, which I modified: [https://gist.github.com/rtd/1121786](https://gist.github.com/rtd/1121786)

