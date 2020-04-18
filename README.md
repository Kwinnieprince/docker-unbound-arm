# docker-unbound-arm
Unbound DNS resolver Docker image for ARM


## Running locally
* if needed, edit [unbound.conf](https://github.com/Kwinnieprince/docker-unbound-arm/blob/master/config/unbound.conf) when you want internal lookups
* in [entrypoint.sh](https://github.com/Kwinnieprince/docker-unbound-arm/blob/master/entrypoint.sh) you can see all the possible env-variables

|  Value  |  Default  |
|----|----|
| DO_IPV6 | yes |
| DO_IPV4 | yes |
| DO_IPV6 | yes |
| DO_UDP | yes |
| DO_TCP | yes |
| VERBOSITY | 0 |
| NUM_THREADS | 1 |
| EDNS_BUFFER_SIZE | 1472 |
| CACHE_MIN_TTL | 3600 |
| CACHE_MAX_TTL | 86400 |
| HIDE_IDENTITY | yes |
| HIDE_VERSION | yes |
| INTERFACE | 0.0.0.0 |
| PORT | 5333 |
| HARDEN_GLUE | yes |

⚠️ When you change the port, edit it in the dockerfile ⚠️

```
docker build -t kwinnieprince/docker-unbound-arm:latest .
docker run -p 5333:5333 kwinnieprince/docker-unbound-arm
```

## Credits
Credits to MASNathan for the docker image
