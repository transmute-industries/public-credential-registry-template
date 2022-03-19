```
docker manifest inspect ghcr.io/transmute-industries/public-credential-registry-template:feat-ghcr-vc-example
```

```
docker inspect ghcr.io/transmute-industries/public-credential-registry-template:feat-ghcr-vc-example --format='{{json .Config.Labels}}' | jq
```
