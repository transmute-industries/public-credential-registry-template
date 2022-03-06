A public credential registry is useful for managing lists of credentials where the privacy of the subject is less imporant than the discoverability of the subject.

Examples include:

- [DNS Root Servers](https://www.iana.org/domains/root/servers)
- [Medical Board Certification](https://www.tmb.state.tx.us/page/resources-advertisement-board-certification)

The purpose of this repository is to provide template for managing public credential registries using:

- GitHub Pages
- Github Actions
- Decentralized Identifiers
- Verifiable Credentials

### Getting Started

You will need to set a github secret for your mnemonic:

```yml
mnemonic: "${{ secrets.MNEMONIC }}"
```
