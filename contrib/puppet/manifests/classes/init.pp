# Class: init
#
class init {
    group { 'puppet':
        ensure => 'present',
    }

    # update the system
    exec { 'apt-update':
        command => 'sudo apt-get update',
    }

    # base dependencies
    package {
        ["python", 'python-dev', 'python-pip']:
        ensure => installed,
        require => Exec['apt-update']
    }

    exec { 'update-pip':
        command => 'sudo pip install -U pip setuptools',
        require => Package['python-pip']
    }

    exec { 'install-requirements':
        cwd => "$PROJECT_DIR",
        command => "sudo pip install -U -r $PROJECT_DIR/requirements.txt",
        tries => 2,
        timeout => 600,  # Too long, but this can take awhile
        require => [Package['python-dev', 'postgresql-devel'], Exec['update-pip']],
        logoutput => on_failure,
    }
}
