# Public Credential Website

A public credential registry is useful for managing lists of credentials where the privacy of the subject is less imporant than the discoverability of the subject.

Examples include:

- [DNS Root Servers](https://www.iana.org/domains/root/servers)
- [Medical Board Certification](https://www.tmb.state.tx.us/page/resources-advertisement-board-certification)

### Getting Started

You will need to setup a [GitHub Action Secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for your `mnemonic`.

You can use [api.did.actor](https://api.did.actor/) or any [BIP 39 mnemonic](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki).

```yml
mnemonic: "${{ secrets.MNEMONIC }}"
```

Next you will need to create a credential issuer that can be hosted in github pages.

```yml
- name: Create Issuer
  id: create_issuer
  uses: transmute-industries/verifiable-actions@v0.0.11
  with:
    resource: "did"
    action: "generate"
    username: "transmute-industries"
    repository: "public-credential-registry-template"
    mnemonic: "${{ secrets.MNEMONIC }}"
    hd-path: "m/44'/0'/0'/0/0"
    key-type: "ed25519"
    # This path has to match what will be expected when resolving a did web.
    file-output: "./issuers/z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn/did.json"
```

This step will create a "did:web" DID Document for the DID:

- did:web:transmute-industries.github.io:public-credential-registry-template:issuers:z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn

This is the identifer that holds the verification keys for claims made in this repository.

Next you will need to create a Verifiable Credential:

```yml
- name: Create a Verifiable Credential
  id: create_registry_credential
  uses: transmute-industries/verifiable-actions@v0.0.11
  with:
    resource: "credential"
    action: "create"
    username: "transmute-industries"
    repository: "public-credential-registry-template"
    mnemonic: "${{ secrets.MNEMONIC }}"
    hd-path: "m/44'/0'/0'/0/0"
    key-type: "ed25519"

    file-input: "./templates/example.json"
    file-output: "./credentials"
```

This step will add a proof to the json example, move it to the credentials directory, and refresh the credential index.

After this step, you will need to publish the registry updates with github pages.

```yml
- name: Deploy Registry
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    enable_jekyll: true
    publish_dir: .
    exclude_assets: ".github"
```

After this workflow succeeds you should be able to see the issuers and credentials for the registry by browsung the published website.

## Issuers

- [issuer](https://transmute-industries.github.io/public-credential-registry-template/issuers/z6MktiSzqF9kqwdU8VkdBKx56EYzXfpgnNPUAGznpicNiWfn/did.json)

## Credentials

- [credentials](https://transmute-industries.github.io/public-credential-registry-template/credentials/)
