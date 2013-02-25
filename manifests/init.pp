class logstash {

    #Variables (will turn these into parameters later on)
    $config_file_path = '/etc/logstash/central.conf'
    $logstash_log_path = '/var/log/logstash/logstash.log'
    $java_runtime_path = '/usr/bin/java'
    $jar_file_path = '/opt/logstash/logstash.jar'
    
    
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
    
   
    file { 'logstash-monolithic-jar-file': 
      path => $jar_file_path,
      ensure => file,
      mode => 644,
      source => 'puppet:///modules/logstash/logstash.jar',
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
    service { 'logstash':
        enable => true,
        ensure => running,
        subscribe => File['config-file'],
        require => [File['config-file'], File['log-file'], File['logstash-init-script'], File['logstash-monolithic-jar-file'], Package['openjdk-7-jre-headless']],
    }
    
}