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
       

       concat{$conf_file:
               owner => root,
               group => root,
               mode => 644
       }

       concat::fragment{"input_container":
               target => $file,
               content => "",
               order => 1,
       }

       concat::fragment{"":
               target => $file,
               content => "\n\n",
               order => 10000,
       }
}

# defined types for the actual config
define motd::register($content="", $order=20) {
   if $content == "" {
      $body = $name
   } else {
      $body = $content
   }

   concat::fragment{"motd_fragment_$name":
      target  => "/etc/motd.tail",
      content => "$body ",
      order => $order
   }
}

}