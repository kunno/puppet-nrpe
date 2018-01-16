# Manage NRPE logging
class nrpe::config::log {

  file { $nrpe::log_file :
    owner  => $nrpe::nrpe_user,
    group  => $nrpe::nrpe_group,
    notify => Class['nrpe::service'],
  }

  logrotate::rule { 'nrpe':
    compress      => true,
    delaycompress => true,
    missingok     => true,
    path          => $nrpe::log_file,
    rotate        => 7,
    rotate_every  => 'day',
    require       => File[$nrpe::log_file],
    postrotate    =>
    "/bin/kill -HUP `cat ${nrpe::pid_file} 2>/dev/null` 2>/dev/null || true",
  }
}
