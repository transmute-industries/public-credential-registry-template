# Public Container Registry

Assuming you have already established an issuer for the credentials.

See [the github workflow create-container.yml](../.github/workflows/create-container.yml).

Once you have successfully published a container, you can pull the credential from the labels on the registry.

```sh
docker pull ghcr.io/transmute-industries/public-credential-registry-template:main
docker inspect ghcr.io/transmute-industries/public-credential-registry-template:main --format='{{json .Config.Labels}}' | jq

docker inspect ghcr.io/transmute-industries/public-credential-registry-template:main \
--format='{{json .Config.Labels}}' | jq -r '."org.opencontainers.image.vc"' | jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson'
```

This will produce the following output:

```json5
// header
{
  "alg": "EdDSA",
  "kid": "did:web:transmute-industries.github.io:public-credential-registry-template:issuers:z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn#z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn"
}
// payload
{
  "iss": "did:key:z6MkoZrhfUbGsBFVqawVgyauvoTA8bsNJWyaAQeVkJYdpvXK",
  "sub": {
    "tags": [
      "ghcr.io/transmute-industries/public-credential-registry-template:main"
    ],
    "labels": {
      "org.opencontainers.image.title": "public-credential-registry-template",
      "org.opencontainers.image.description": "Public Credential Registry Template",
      "org.opencontainers.image.url": "https://github.com/transmute-industries/public-credential-registry-template",
      "org.opencontainers.image.source": "https://github.com/transmute-industries/public-credential-registry-template",
      "org.opencontainers.image.version": "main",
      "org.opencontainers.image.created": "2022-03-20T20:22:50.574Z",
      "org.opencontainers.image.revision": "82673ae15e134047e06b9dede5018bceed154c7f",
      "org.opencontainers.image.licenses": "Apache-2.0"
    }
  },
  "vc": {
    "@context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://w3id.org/security/suites/jws-2020/v1",
      {
        "@vocab": "https://ontology.example/vocab/#"
      }
    ],
    "id": "https://transmute-industries.github.io/public-credential-registry-template/credentials/container-credential-example.json",
    "type": [
      "VerifiableCredential",
      "CertifiedContainer"
    ],
    "issuanceDate": "2022-01-15T19:25:55.574Z",
    "issuer": {
      "id": "did:key:z6MkoZrhfUbGsBFVqawVgyauvoTA8bsNJWyaAQeVkJYdpvXK",
      "type": "Organization",
      "name": "Transmute",
      "description": "Decentralized Identifiers and Verifiable Credentials for Software Supply Chain"
    },
    "credentialSubject": {
      "tags": [
        "ghcr.io/transmute-industries/public-credential-registry-template:main"
      ],
      "labels": {
        "org.opencontainers.image.title": "public-credential-registry-template",
        "org.opencontainers.image.description": "Public Credential Registry Template",
        "org.opencontainers.image.url": "https://github.com/transmute-industries/public-credential-registry-template",
        "org.opencontainers.image.source": "https://github.com/transmute-industries/public-credential-registry-template",
        "org.opencontainers.image.version": "main",
        "org.opencontainers.image.created": "2022-03-20T20:22:50.574Z",
        "org.opencontainers.image.revision": "82673ae15e134047e06b9dede5018bceed154c7f",
        "org.opencontainers.image.licenses": "Apache-2.0"
      }
    }
  },
  "jti": "https://transmute-industries.github.io/public-credential-registry-template/credentials/container-credential-example.json",
  "nbf": 1642274755
}
```

Because this Verifiable Credential is also a standards compliant JWT, you can verify it with many off the shelf libraries.

```sh
open "https://api.did.actor/v/$(docker inspect ghcr.io/transmute-industries/public-credential-registry-template:main --format='{{json .Config.Labels}}' | jq -r '."org.opencontainers.image.vc"')"
```

If the DID associated with this credential revokes the issuance keys in in the future, the verification will fail.
