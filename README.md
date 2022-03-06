# Public Credential Registry

[![Public Credential Registry](https://github.com/transmute-industries/public-credential-registry-template/actions/workflows/ci.yml/badge.svg)](https://github.com/transmute-industries/public-credential-registry-template/actions/workflows/ci.yml)

A zero code public credentials registry, powered by github actions, workflows and pages.

## Issuers

- [issuer](https://transmute-industries.github.io/public-credential-registry-template/issuers/z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn/did.json)

## Credentials

- [credentials](https://transmute-industries.github.io/public-credential-registry-template/credentials/)

### About Template

A public credential registry is useful for managing lists of credentials where the privacy of the subject is less imporant than the discoverability of the subject.

Examples include:

- [DNS Root Servers](https://www.iana.org/domains/root/servers)
- [Medical Board Certification](https://www.tmb.state.tx.us/page/resources-advertisement-board-certification)

The purpose of this repository is to provide a template for managing public credential registries using:

- GitHub Pages
- Github Actions
- Decentralized Identifiers
- Verifiable Credentials

### Getting Started

You will need to setup a [GitHub Action Secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for your `mnemonic`.

You can use [api.did.actor](https://api.did.actor/) or any [BIP 39 mnemonic](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki).

```yml
mnemonic: "${{ secrets.MNEMONIC }}"
```
