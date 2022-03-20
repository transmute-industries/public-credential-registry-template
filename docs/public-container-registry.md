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

Or [direct-link-to-example](https://api.did.actor/v/eyJhbGciOiJFZERTQSIsImtpZCI6ImRpZDp3ZWI6dHJhbnNtdXRlLWluZHVzdHJpZXMuZ2l0aHViLmlvOnB1YmxpYy1jcmVkZW50aWFsLXJlZ2lzdHJ5LXRlbXBsYXRlOmlzc3VlcnM6ejZNa3RpU3pxRjlrcXdkVThWa2RCS3g1NkVZelhmcGduTlBVQUd6bnBpY05pV2ZuI3o2TWt0aVN6cUY5a3F3ZFU4VmtkQkt4NTZFWXpYZnBnbk5QVUFHem5waWNOaVdmbiJ9.eyJpc3MiOiJkaWQ6a2V5Ono2TWtvWnJoZlViR3NCRlZxYXdWZ3lhdXZvVEE4YnNOSld5YUFRZVZrSllkcHZYSyIsInN1YiI6eyJ0YWdzIjpbImdoY3IuaW8vdHJhbnNtdXRlLWluZHVzdHJpZXMvcHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGU6bWFpbiJdLCJsYWJlbHMiOnsib3JnLm9wZW5jb250YWluZXJzLmltYWdlLnRpdGxlIjoicHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGUiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2UuZGVzY3JpcHRpb24iOiJQdWJsaWMgQ3JlZGVudGlhbCBSZWdpc3RyeSBUZW1wbGF0ZSIsIm9yZy5vcGVuY29udGFpbmVycy5pbWFnZS51cmwiOiJodHRwczovL2dpdGh1Yi5jb20vdHJhbnNtdXRlLWluZHVzdHJpZXMvcHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGUiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2Uuc291cmNlIjoiaHR0cHM6Ly9naXRodWIuY29tL3RyYW5zbXV0ZS1pbmR1c3RyaWVzL3B1YmxpYy1jcmVkZW50aWFsLXJlZ2lzdHJ5LXRlbXBsYXRlIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLnZlcnNpb24iOiJtYWluIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLmNyZWF0ZWQiOiIyMDIyLTAzLTIwVDIwOjIyOjUwLjU3NFoiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2UucmV2aXNpb24iOiI4MjY3M2FlMTVlMTM0MDQ3ZTA2YjlkZWRlNTAxOGJjZWVkMTU0YzdmIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLmxpY2Vuc2VzIjoiQXBhY2hlLTIuMCJ9fSwidmMiOnsiQGNvbnRleHQiOlsiaHR0cHM6Ly93d3cudzMub3JnLzIwMTgvY3JlZGVudGlhbHMvdjEiLCJodHRwczovL3czaWQub3JnL3NlY3VyaXR5L3N1aXRlcy9qd3MtMjAyMC92MSIseyJAdm9jYWIiOiJodHRwczovL29udG9sb2d5LmV4YW1wbGUvdm9jYWIvIyJ9XSwiaWQiOiJodHRwczovL3RyYW5zbXV0ZS1pbmR1c3RyaWVzLmdpdGh1Yi5pby9wdWJsaWMtY3JlZGVudGlhbC1yZWdpc3RyeS10ZW1wbGF0ZS9jcmVkZW50aWFscy9jb250YWluZXItY3JlZGVudGlhbC1leGFtcGxlLmpzb24iLCJ0eXBlIjpbIlZlcmlmaWFibGVDcmVkZW50aWFsIiwiQ2VydGlmaWVkQ29udGFpbmVyIl0sImlzc3VhbmNlRGF0ZSI6IjIwMjItMDEtMTVUMTk6MjU6NTUuNTc0WiIsImlzc3VlciI6eyJpZCI6ImRpZDprZXk6ejZNa29acmhmVWJHc0JGVnFhd1ZneWF1dm9UQThic05KV3lhQVFlVmtKWWRwdlhLIiwidHlwZSI6Ik9yZ2FuaXphdGlvbiIsIm5hbWUiOiJUcmFuc211dGUiLCJkZXNjcmlwdGlvbiI6IkRlY2VudHJhbGl6ZWQgSWRlbnRpZmllcnMgYW5kIFZlcmlmaWFibGUgQ3JlZGVudGlhbHMgZm9yIFNvZnR3YXJlIFN1cHBseSBDaGFpbiJ9LCJjcmVkZW50aWFsU3ViamVjdCI6eyJ0YWdzIjpbImdoY3IuaW8vdHJhbnNtdXRlLWluZHVzdHJpZXMvcHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGU6bWFpbiJdLCJsYWJlbHMiOnsib3JnLm9wZW5jb250YWluZXJzLmltYWdlLnRpdGxlIjoicHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGUiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2UuZGVzY3JpcHRpb24iOiJQdWJsaWMgQ3JlZGVudGlhbCBSZWdpc3RyeSBUZW1wbGF0ZSIsIm9yZy5vcGVuY29udGFpbmVycy5pbWFnZS51cmwiOiJodHRwczovL2dpdGh1Yi5jb20vdHJhbnNtdXRlLWluZHVzdHJpZXMvcHVibGljLWNyZWRlbnRpYWwtcmVnaXN0cnktdGVtcGxhdGUiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2Uuc291cmNlIjoiaHR0cHM6Ly9naXRodWIuY29tL3RyYW5zbXV0ZS1pbmR1c3RyaWVzL3B1YmxpYy1jcmVkZW50aWFsLXJlZ2lzdHJ5LXRlbXBsYXRlIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLnZlcnNpb24iOiJtYWluIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLmNyZWF0ZWQiOiIyMDIyLTAzLTIwVDIwOjIyOjUwLjU3NFoiLCJvcmcub3BlbmNvbnRhaW5lcnMuaW1hZ2UucmV2aXNpb24iOiI4MjY3M2FlMTVlMTM0MDQ3ZTA2YjlkZWRlNTAxOGJjZWVkMTU0YzdmIiwib3JnLm9wZW5jb250YWluZXJzLmltYWdlLmxpY2Vuc2VzIjoiQXBhY2hlLTIuMCJ9fX0sImp0aSI6Imh0dHBzOi8vdHJhbnNtdXRlLWluZHVzdHJpZXMuZ2l0aHViLmlvL3B1YmxpYy1jcmVkZW50aWFsLXJlZ2lzdHJ5LXRlbXBsYXRlL2NyZWRlbnRpYWxzL2NvbnRhaW5lci1jcmVkZW50aWFsLWV4YW1wbGUuanNvbiIsIm5iZiI6MTY0MjI3NDc1NX0.2zLNWxL1Q2frypqjnO_T90uR0H-iy5trGbaWvbMPsPXaSN-SrCYdmsPbBS5zY6SufQoMKgf2IFwnJX94qjYQAQ)

If the DID associated with this credential revokes the issuance keys in in the future, the verification will fail.
