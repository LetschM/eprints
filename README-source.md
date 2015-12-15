Build from source
=================

For Ubuntu/Debian

## Install prerequisites

```
sudo apt-get install automake autoconf make
```

## Create user / group 'eprints'

```
sudo useradd eprints
```

## Install Perl modules from CPAN

```
perl cpan_modules.pl
```

## Run autotool chain

```
aclocal
autoconf
automake --add-missing
./configure
make
```

## Install eprints to `/opts/eprints3`

```
sudo perl install.pl
# Follow the instructions
```

## Change group permissions on `/opts/eprints3`

```
sudo chgrp -R www-data /opts/eprints3
```

## Become user `eprints`

```
sudo -u eprints bash
```

## Create Apache2 config

```
cd /opts/eprints3
./bin/generate_apacheconf
```

## Include `/opts/eprints3/cfg/<NAME>/apache.conf` in apache config

```
# Adapt /etc/apache2/sites-enabled / /etc/httpd.conf / /etc/apache2/apache2.conf accordingly
```

...
