## ARCHIVED

I recently started working again with Github Actions and given the fact that I needed to send build arguments and secrets to the Dockerfile I started to look at all the alternatives available as those are not supported in this repo.

I found that the `docker/build-push-action` works for pushing into the GHCR as well, so what was the biggest benefit of this action is now taken care somewhere else with more features and mainteinance. Therefore I suggest that you switch over to that one, I leave below a little snippet on how I used the action:

```
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v3

- name: Login to GHCR
  uses: docker/login-action@v3
  with:
    registry: ghcr.io/my-org
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}

- name: Build and push
  uses: docker/build-push-action@v5
  with:
    push: true
    tags: |
      ghcr.io/my-org/my-svc:latest
      ghcr.io/my-org/my-svc:some-tag
    build-args: |
      "x=y"
      "foo=bar"
    secrets: |
      "secret-id=${{secrets.SECRET_VALUE}}"
```

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

      - uses: pmorelli92/github-container-registry-build-push@2.2.1
        name: Build and Publish latest service image
        with:
          github-push-secret: ${{secrets.GITHUB_TOKEN}}
          docker-image-name: my-svc
          docker-image-tag: latest # optional
          dockerfile-path: Dockerfile # optional
          build-context: . # optional
          build-only: false # optional
          docker-build-args: FOO=BAR,OTHER=VALUE # optional
```

## Inspirations and acknowledgments

I heavily inspired on [gp-docker-action](https://github.com/VaultVulp/gp-docker-action) repository made by [Pavel Alimpiev](https://github.com/VaultVulp). This mentioned repo is pushing towards the *GitHub Packages Docker Registry* instead of the new *GitHub Container Registry*.

[More information on the new Github Container Registry here.](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images)
