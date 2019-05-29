# Ipaddr

This is the software that runs the https://ipaddr.tools site.

## Installation

1. Clone the project.
```
git clone git@github.com:s-stepien/ipaddr.tools.git
```

2. Install needed dependencies and databases.

```
cd ipaddr.tools
mix deps.get
mix compile
mix ipaddr.db.install
```

This product includes GeoLite2 data created by MaxMind, available from
[https://www.maxmind.com](https://www.maxmind.com).

3. Configure.

See [Configuration](#configuration).

4. Run!
```
sudo mix run --no-halt
```

or
```
sudo iex -S mix
```

## Configuration

Before you can run this application you need to make some effort to configure it
correctly.

### SSL certificates

This application uses by default HTTPS, so correct SSL certificates are needed.
I think that the simples way to get the certificates is by using the
[certbot](https://certbot.eff.org/) for [Let's
Encrypt](https://letsencrypt.org/). Check them out - it is easy!

You can also use existing certificates if you have them already.

Note: the Let's Encrypt certificates (and maybe others) are not recognized by
some tools (e.g.  curl). So keep in mind that using HTTPS with that tools might
not work.

#### SSL certificates configuration

You need to enter the paths to certificate file and private key file inside
`lib/ipaddr/application.ex` file:

```
Plug.Cowboy.child_spec(scheme: :https, plug: Ipaddr.Router, options: [
  port: 443,
  certfile: "/etc/letsencrypt/live/ipaddr.tools/fullchain.pem",
  keyfile: "/etc/letsencrypt/live/ipaddr.tools/privkey.pem",
]),
```

Change the paths for values: `certfile` and `keyfile`.

If you do not need HTTPS support, remove or comment the whole code from above.

### Working behind proxy

If you are planning to use this software behind proxy (e.g. nginx), you need to
install additional software that will allow a correct readout of remote IP
address (see: [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For)).

#### remote_ip

The [remote_ip](https://hex.pm/packages/remote_ip) hex package will allow Plug
to read the client IP and not the IP of the proxy server. To enable it in the
application uncomment (remove `#` character) two lines:

`mix.exs`:
```
#{:remote_ip, "~> 0.1.0"},
```

and `lib/http/router.ex`:
```
#plug RemoteIp
```

Then, install the package:
```
mix deps.get
```

and restart the application.

#### When proxy is using SSL certificates

If your proxy is using SSL, and you would like to run this application with
just plain HTTP, you need to change how the HTTP server is started.

See [above](#ssl-certificates-configuration) which lines should be removed or
commented.

## Updating geolocation databases

If you wish to update the geolocation databases, you can do that without
stopping the application by running:
```
mix ipaddr.db.update
```

This will download the newest databases from the MaxMind site, and will reload
it inside the running application.

Note: the reload will finish after some slight delay (see [Geolix docs](https://hexdocs.pm/geolix/readme.html#reloading)).
