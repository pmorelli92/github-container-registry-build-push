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

      - uses: pmorelli92/github-container-registry-build-push@2.2.0
        name: Build and Publish latest service image
        with:
          github-push-secret: ${{secrets.GITHUB_TOKEN}}
          docker-image-name: my-svc
          docker-image-tag: latest # optional
          dockerfile-path: ./src/svc/Dockerfile # optional
          build-context: ./src/svc # optional
          build-only: false # optional
          docker-build-args: |- #optional
            FOO=BAR
            OTHER=VALUE
```

## Inspirations and acknowledgments

I heavily inspired on [gp-docker-action](https://github.com/VaultVulp/gp-docker-action) repository made by [Pavel Alimpiev](https://github.com/VaultVulp). This mentioned repo is pushing towards the *GitHub Packages Docker Registry* instead of the new *GitHub Container Registry*.

[More information on the new Github Container Registry here.](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images)
