class database {
    class { 'postgresql::globals':
        encoding => 'UTF8',
        locale  => 'en_US.utf8',
        manage_package_repo => true,
        version => '9.2',
    }->
    class { 'postgresql::server':
        ip_mask_deny_postgres_user => '0.0.0.0/32',
        ip_mask_allow_all_users => '0.0.0.0/0',
        listen_addresses => '*',
        postgres_password => 'password',
    }
    class { 'postgresql::lib::devel': }

    postgresql::server::db { 'appdb':
        user => 'app',
        password => postgresql_password('app', 'password'),
    }
}
