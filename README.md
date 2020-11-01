# Quick reference

- **Maintained by**: [Valentin Lahaye](https://github.com/vallahaye/docker-mumbledj)

- **Where to file issues**: [https://github.com/vallahaye/docker-mumbledj/issues](https://github.com/vallahaye/docker-mumbledj/issues)

# How to use this image

## Simple command-line configuration to use the YouTube service

Build the image using the following commands:

```console
$ git clone https://github.com/vallahaye/docker-mumbledj.git
$ cd docker-mumbledj
$ docker build . -t mumbledj
```

```console
$ docker run -d --name mumbledj --restart=unless-stopped mumbledj --server='SERVER_ADDRESS' --api_keys.youtube='YOUTUBE_API_KEY'
```

## Complex configuration

```console
$ wget https://raw.githubusercontent.com/matthieugrieger/mumbledj/master/config.yaml -O mumbledj-config.yaml
```

Edit the configuration file as needed, then run a container with it mounted inside.

For information on the syntax of the configuration file, see [the official documentation](https://github.com/matthieugrieger/mumbledj/blob/138c1008eb51b2245e62f504f4583e4e0a1dc5ae/README.md).

```console
$ docker run -d --name mumbledj --restart=unless-stopped -v /host/path/mumbledj-config.yaml:/root/.config/mumbledj/config.yaml:ro mumbledj
```

## Entrypoint quiet logs

A verbose entrypoint is available to provide information on what's happening during container startup. You can silence this output by setting environment variable `MUMBLEDJ_ENTRYPOINT_QUIET_LOGS`:

```console
$ docker run -d -e MUMBLEDJ_ENTRYPOINT_QUIET_LOGS=1 mumbledj
```

# License

View [license information](https://github.com/matthieugrieger/mumbledj/blob/master/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
