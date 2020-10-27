Bash + Nginx CGI Example
================

> Note: A pervious version of this README mentioned [Python's CGIHTTPServer ver.2](http://docs.python.org/2/library/cgihttpserver.html), which is out of date. CGIHTTPServer is actually not needed for a this example at all.

As [Nginx](http://nginx.org/) only supports FastCGI out of the box,
we also need to install [fcgiwrap](https://github.com/gnosek/fcgiwrap).

On Ubuntu: `apt-get install nginx fcgiwrap`  
On Arch: `pacman -S nginx fcgiwrap`

Example Nginx config (Ubuntu: `/etc/nginx/sites-enabled/default`):
```
server {
    listen   80;
    server_name  localhost;
    access_log  /var/log/nginx/access.log;

    location / {
        root /srv/static;
        autoindex on;
        index index.html index.htm;
    }

    location ~ ^/cgi-bin {
        root /srv/cgi-bin;
        rewrite ^/cgi-bin/(.*) /$1 break;

        include fastcgi_params;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
        fastcgi_param SCRIPT_FILENAME /srv/cgi-bin$fastcgi_script_name;
    }
}
```

If necessary, change the **root** and **fastcgi_param** lines to a directory containing CGI
scripts, e.g. the `cgi-bin/` dir in this repository.

Run `sudo chmod +x /srv/cgi-bin/*` so the scripts will execute.

If you are a control freak and run `fcgiwrap` manually,
be sure to change **fastcgi_pass** accordingly. The path listed in the example
is the default in Ubuntu when using the out-of-the-box fcgiwrap setup.
