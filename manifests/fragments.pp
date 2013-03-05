# == Class: logstash
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

class logstash::fragments { 



       include concat::setup
       $motdfile = ""

       concat{$file:
               owner => root,
               group => root,
               mode => 644
       }

       concat::fragment{"":
               target => $file,
               content => "",
               order => 10,
       }

       concat::fragment{"":
               target => $file,
               content => "\n\n",
               order => 90,
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