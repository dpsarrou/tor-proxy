# Tor proxy container based on alpine linux

A simple tor proxy based on alpine linux configured to listen on socks5 protocol:

    socsk5://0.0.0.0:9150

The `control port` is set to `9050`

## Usage

Typical usecase of proxying another container's outgoing network traffic via a `docker-compose.yml`:

    version: '2.4'
    services:
        proxy:
            build: cminor/tor-proxy:latest
        curl:
            image: curlimages/curl:latest
            environment:
                ALL_PROXY: socks5://proxy:9150
            depends_on:
                - proxy

To test it works:

    docker-compose run --rm curl curl https://check.torproject.org | grep Congratulations

Expected output:

      Congratulations. This browser is configured to use Tor.

\*Note that in most cases (such as http requests from `Golang`) setting the environment variable `HTTP_PROXY` is enough. However `curl` does not read this variable (I haven't spent much time to investigate why) but using the `ALL_PROXY` will do the trick. See a;also [this](https://ec.haxx.se/usingcurl/usingcurl-proxies#proxy-environment-variables) if interested for more information.

## Customization

The [image](./Dockerfile) is very simple and should work out of the box for most use cases. If you would like to customize `Tor` you can provide your own `torrc` configuration file, either by volume sharing in your `docker-compose.yml` file:

    volumes:
        ./my-torrc:/etc/tor/torrc

or extending this [dockerfile](./Dockerfile) and copying your own:

    FROM cminor/tor-proxy:latest
    COPY ./my-torrc:/etc/tor/torrc

## Development

To build this image use the provided `Makefile`:

    make build

To publish to dockerhub use:

    make publish
