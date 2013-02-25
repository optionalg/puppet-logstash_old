puppet-logstash
====================

A module to install and configure logstash.

This is for Debian/Ubuntu.

###Usage

Download the latest monolithic .jar file from [Logstash's website](http://logstash.net/). Place it in the `files/` folder of the module and rename it to `logstash.jar`.

In the **Variables** section at the top of `init.pp`, you can specify values for several things but the only one you should really check is the location of your machine's Java runtime binary (usually at `/usr/bin/java`). 

In your `site.pp`, apply the `logstash` class to a node:

<pre>
node 'logstash-server' {
    include logstash
}
</pre>

Yes, I will expose turn this into a parameterized class later on.
