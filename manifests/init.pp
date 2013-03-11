# == Class: logstash
#
# This base class installs and configures Logstash and runs it as a service.
#
# === Parameters
#
# [*config_file_path*]
#   The path for the `.conf` file Logstash wil load. Defaults to `/etc/logstash/central.conf`.
#
# [*logstash_log_path*]
#   The path for the logfile that Logstash will log its own events to. Defaults to `/var/log/logstash/logstash.log`.
#
# [*java_runtime_path*]
#   The path to the Java runtime binary. Defaults to `/usr/bin/java`
#
# [*jar_file_path*]
#   The path where the Logstash monolithic .jar file will be placed and run from. Defaults to `/opt/logstash/logstash.jar`.
#
# [*logstash_version*]
#  The version of Logstash you want to download and install.
#
# === Examples
# 
#   class {'logstash':
#     config_file_path   => '/etc/logstash/central.conf',
#     logstash_log_path  => '/var/log/logstash/logstash.log',
#     java_runtime_path  => '/usr/bin/java',
#     jar_file_path      => '/opt/logstash/logstash.jar'
#     logstash_version   => '1.1.9',
# }
#
#
class logstash (
  $config_file_path = '/etc/logstash/central.conf',
  $logstash_log_path = '/var/log/logstash/logstash.log',
  $java_runtime_path = '/usr/bin/java',
  $jar_file_path = '/opt/logstash/logstash.jar',
  $logstash_version = '1.1.9'
) {
        
    #File resources
    
    #The init script itself
    file { 'logstash-init-script':
      path => '/etc/init.d/logstash',
      ensure => file,
      mode => 755,
      content => template('logstash/logstash.sh.erb'),
    }
    
    #The monolithic logstash.jar file and its containing folder
    
    file { '/opt/logstash':
        ensure => directory,
        mode => 755,
    }
    
    exec { 'download-logstash':
      cwd => '/opt/logstash',
      path => '/usr/bin',
      command => "wget https://logstash.objects.dreamhost.com/release/logstash-${logstash_version}-monolithic.jar -O /opt/logstash/logstash-${logstash_version}-monolithic.jar",
      creates => "/opt/logstash/logstash-${logstash_version}-monolithic.jar",
      require => File['/opt/logstash'],
    }
   
    file { 'logstash-monolithic-jar-file': 
      path => $jar_file_path,
      ensure => file,
      mode => 644,
      #source => 'puppet:///modules/logstash/logstash.jar',
    }
    
    #Logstash's .conf file that sets up inputs, filters and outputs (and its containing folder)
    file { '/etc/logstash':
      ensure => directory,
      mode => 755,
    }
    
    file { 'config-file':
      path => $config_file_path,
      ensure => file,
      mode => 644,
      source => 'puppet:///modules/logstash/central.conf',
    }
    
    #Where Logstash's own logs will be kept (creating the directory first because it probably won't exist yet)
    file { '/var/log/logstash':
      ensure => directory,
      mode => 755,
    }
    
    file { 'log-file':
      #ensure => file,
      path => $logstash_log_path,
      mode => 644,
    }
    
    #Package resources
    
    #The OpenJDK Java 7 runtime
	package { 'openjdk-7-jre-headless':
	  ensure => installed,
	  provider => 'apt',
	}
    
    #Service resources
    
    #Logstash itself. Require the files above and subscribe it to the config file
    #so it restarts automatically when changes to the .conf file are made.
    service { 'logstash':
        ensure => running,
        #start => "/etc/init.d/logstash start",
        #stop => "/etc/init.d/logstash stop",
        #restart => "/etc/init.d/logstash restart",
        #status => "/etc/init.d/logstash status",
        #hasstatus => true,
        #hasrestart => true,
        provider => "init",
        subscribe => File['config-file'],
        require => [File['log-file'], File['logstash-init-script'], File['logstash-monolithic-jar-file'], Package['openjdk-7-jre-headless']],
    }
    
}