class python::install {

  $python = $python::version ? {
    'system' => 'python',
    default  => "python${python::version}",
  }

  if $::operatingsystem == "Gentoo" {
  } else {
    $pythondev = $::operatingsystem ? {
      /(?i:RedHat|CentOS|Fedora)/ => "${python}-devel",
      /(?i:Debian|Ubuntu)/        => "${python}-dev"
    }
    package { $pythondev: ensure => $dev_ensure }
  }

  package { $python: ensure => present }

  $dev_ensure = $python::dev ? {
    true    => present,
    default => absent,
  }

  $pip_ensure = $python::pip ? {
    true    => present,
    default => absent,
  }

  if $::operatingsystem == "Gentoo" {
    package { 'python-pip': 
      ensure => $pip_ensure,
      name => 'pip',
      category => 'dev-python',
    }
  } else {
    package { 'python-pip': ensure => $pip_ensure }
  }

  $venv_ensure = $python::virtualenv ? {
    true    => present,
    default => absent,
  }

  if $::operatingsystem == "Gentoo" {
    package { 'python-virtualenv': 
      ensure => $venv_ensure,
      name => 'virtualenv',
      category => 'dev-python',
    }
  } else {
    package { 'python-virtualenv': ensure => $venv_ensure }
  }

  $gunicorn_ensure = $python::gunicorn ? {
    true    => present,
    default => absent,
  }

  package { 'gunicorn': ensure => $gunicorn_ensure }

}
