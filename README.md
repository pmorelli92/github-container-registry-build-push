# GitHub Container Registry : Build and push

Github Action that builds and pushes a docker image to Github Container Registry.

## Example

```yaml
jobs:
  build-svc:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        name: Checkout repository

      - uses: pmorelli92/github-container-registry-build-push@1.0.0
        name: Build and Publish latest service image
        with:
          # Read note below to see how to generate the PAT
          personal-access-token: ${{secrets.GHCR_PAT}}
          docker-image-name: my-svc
          docker-image-tag: latest
          dockerfile-path: ./src/database/Dockerfile
          build-context: ./src/database
```

## Generate PAT

For generating the PAT (Personal Access Token) you can follow [this guide from GitHub.](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images#authenticating-with-the-container-registry). As the guide indicates, the PAT should be stored under the repository secret variables and referenced via `${{secrets.SECRET_NAME}}`.

## Inspirations and acknowledgments

I heavily inspired on [gp-docker-action](https://github.com/VaultVulp/gp-docker-action) repository made by [Pavel Alimpiev](https://github.com/VaultVulp). This mentioned repo is pushing towards the *GitHub Packages Docker Registry* instead of the new *GitHub Container Registry*.

[More information on the new Github Container Registry here.](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images)
