#!/usr/bin/env ruby

if ARGV.size == 0 || ARGV.include?("-h") || ARGV.include?("--help")
    puts "Usage: #{__FILE__} EXT [EXT ...]"
    exit 1
end

exts = {
    "gd" => {
        "pkg" => [ "libjpeg-dev", "libpng12-dev" ],
        "before" => "docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr",
        "install_method" => "docker-php-ext-install"
    },
    "curl" => {
        "pkg" => [ "libcurl4-gnutls-dev" ],
        "install_method" => "docker-php-ext-install"
    },
    "mysqli" => {
        "install_method" => "docker-php-ext-install"
    },
    "opcache" => {
        "install_method" => "docker-php-ext-install"
    },
    "pdo_mysql" => {
        "install_method" => "docker-php-ext-install"
    },
    "mbstring" => {
        "install_method" => "docker-php-ext-install"
    },
    "intl" => {
        "pkg" => [ "zlib1g-dev", "libicu-dev", "g++" ],
        "install_method" => "docker-php-ext-install"
    },
    "zip" => {
        "pkg" => [ "zlib1g-dev" ],
        "install_method" => "docker-php-ext-install"
    },
    "bcmath" => {
        "install_method" => "docker-php-ext-install"
    },
    "bz2" => {
        "pkg" => [ "libbz2-dev" ],
        "install_method" => "docker-php-ext-install"
    },
    "calendar" => {
        "install_method" => "docker-php-ext-install"
    },
    "dba" => {
        "install_method" => "docker-php-ext-install"
    },
    "exif" => {
        "install_method" => "docker-php-ext-install"
    },
    "gettext" => {
        "install_method" => "docker-php-ext-install"
    },
    "mcrypt" => {
        "pkg" => [ "libmcrypt-dev" ],
        "install_method" => "docker-php-ext-install"
    },
    "mysql" => {
        "install_method" => "docker-php-ext-install"
    },
    "pcntl" => {
        "install_method" => "docker-php-ext-install"
    },
    "shmop" => {
        "install_method" => "docker-php-ext-install"
    },
    "soap" => {
        "pkg" => [ "libxml2-dev" ],
        "install_method" => "docker-php-ext-install",
    },
    "sockets" => {
        "install_method" => "docker-php-ext-install"
    },
    "sysvmsg" => {
        "install_method" => "docker-php-ext-install"
    },
    "sysvsem" => {
        "install_method" => "docker-php-ext-install"
    },
    "sysvshm" => {
        "install_method" => "docker-php-ext-install"
    },
    "wddx" => {
        "install_method" => "docker-php-ext-install"
    },
    "imagick" => {
        "pkg" => [ "libmagickwand-dev" ],
        "install_method" => "pecl",
        "after" => "echo 'extension=imagick.so' > /usr/local/etc/php/conf.d/ext-imagick.ini"
    },
    "recode" => {
        "pkg" => [ "librecode0", "librecode-dev" ],
        "install_method" => "docker-php-ext-install"
    },
    "json" => {
        "install_method" => "docker-php-ext-install"
    }
    #libxslt-dev
}

install_method = {
    "docker-php-ext-install" => [],
    "pecl" => []
}

packages = []
befores  = []
afters   = []

ARGV.each do |ext|
    if exts[ext]
        packages.concat exts[ext]["pkg"] if exts[ext]["pkg"]
        befores << exts[ext]["before"] if exts[ext]["before"]
        afters << exts[ext]["after"] if exts[ext]["after"]
        install_method[exts[ext]["install_method"]] << ext
    else
        puts "Ext #{ext} non gere"
    #     puts "
    # \"#{ext}\" => {
    #     \"pkg\" => [],
    #     \"before\" => \"\",
    #     \"install_method\" => \"docker-php-ext-install\",
    # },"
    end
end

if packages.size > 0
    puts "
RUN apt-get update ; apt-get install -y \\
        #{packages.join(" \\\n        ")} ;\\
    rm -rf /var/lib/apt/lists/*
"
end
if befores.size > 0
    puts "RUN #{befores.join(" ; ")}"
end
if install_method["docker-php-ext-install"].size > 0
    puts "RUN docker-php-ext-install #{install_method["docker-php-ext-install"].join(" ")}"
end
if install_method["pecl"].size > 0
    install_method["pecl"].each do |ext|
        puts "RUN pecl install #{ext}"
    end
end
if afters.size > 0
    puts "RUN #{afters.join(" ; ")}"
end
