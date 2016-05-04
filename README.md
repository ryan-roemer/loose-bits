Loose Bits
==========

Jekyll repo for loose-bits.com

## Development

Watch last 3 posts and have relative root (instead of `http://loose-bits.com`).

```
$ jekyll serve \
  --config _config.yml,_config-dev.yml \
  --incremental \
  --watch \
  --limit 3
```

## Production

Watch everything:

```
$ jekyll serve --watch
```
