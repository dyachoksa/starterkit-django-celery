# Default dev manifest

$PROJECT_DIR = "/vagrant"

import "classes/*.pp"

Exec {
    path => "/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin",
}

class dev {
    class {
        init:;
        database:;
        services:;
    }
}

include dev
