# == Class: logstash::fragments
#
# This base class installs and configures Logstash's shipper.conf.
# 
#
# === Parameters
# 
#
#
#
#
#
#
#
# === Examples
# 
#
#
#
#
#
#
#

class logstash::config_fragments { 

    include concat::setup
    $conf_file_name = 'central.conf'
    
    #The file the fragments are getting placed into
    concat{"$logstash::confd_path/$conf_file_name":
        owner => root,
        group => root,
        mode => 644,
    }

}

# defined types for the actual config
define logstash::config_fragments::add( 
    $order=20,
    $ 
    $option = "",
    $value = "",
) {

   concat::fragment{"motd_fragment_$name":
      target  => "/etc/motd.tail",
      content => "$option => value",
      order => $order
   }

}