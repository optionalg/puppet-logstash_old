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

    #defined types for the actual config
    define logstash::config_fragments::add_input (
        $option = "",
        $value = "",
    ) {



    }
    
    #defined types for the actual config
    define logstash::config_fragments::add_filter (
        $option = "",
        $value = ""
    ) {



    }
    
    #defined types for the actual config
    define logstash::config_fragments::add_output (
        $option = "",
        $value = ""
    ) {



    }

}

