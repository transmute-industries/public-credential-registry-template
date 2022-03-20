```
docker pull ghcr.io/transmute-industries/public-credential-registry-template:main
docker manifest inspect ghcr.io/transmute-industries/public-credential-registry-template:main
docker inspect ghcr.io/transmute-industries/public-credential-registry-template:main --format='{{json .Config.Labels}}' | jq

docker inspect ghcr.io/transmute-industries/public-credential-registry-template:main \
--format='{{json .Config.Labels}}' | jq -r '."org.opencontainers.image.vc"'

```
