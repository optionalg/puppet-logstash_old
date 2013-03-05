# == Defined type: logstash::config_file
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

define logstash::config_file (
    $file_name = title,
    
) {

    file { '${file_name}': 
        path => "${confd_path}/${file_name}",
        ensure => file,
        mode => 644,
        owner => root,
        content => template('logstash/config_file.conf.erb'),   
    }
}
