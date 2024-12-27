# drone-github-mirror

## Issue Tracker

No issue tracker is supported right now. Send issues to byterazor@federationhq.de.

## Description

This repository contains the Containerfile for building a drone github mirror/push plugin.
It verifies that a repository with a given name exist at github. If not it 
will create a new repository without issues and wiki.
It will update the repository description and homepage according to the provided ones
and will in the end push everything to the github repository.

### Aim
The aim of this plugin is to keep a github mirror from local repositories but provide 
different locations for issues and wiki.

## USAGE

### PLUGIN Variables
#### Mandatory
* `GH_TOKEN` - a github access token with access to repo management
* `GH_REPO` - the full name of the github repository including organization or user prefix
* `GH_REPO_DESC` - the short discription of the github repository. Will be updated on each run.
* `GH_REPO_HOMEPAGE` - the homepage the github repository should link to
#### Optional
* `PLUGIN_GH_REPO_TOPICS` - space seperated list of github topics to append to the topic list of the repository at github.

## Supported Architectures

- amd64
- arm64

## Container Images

## Prebuild Images
Prebuild images are provided at docker hub:

* https://hub.docker.com/repository/docker/byterazor/drone-github-mirror/general

I am trying to update the image weekly as long as my private kubernetes cluster is available. 
So I do not promise anything and do **not** rely your business on this image.

## Source Repository

* https://gitea.federationhq.de/Container/drone-github-mirror


## Authors

* **Dominik Meyer** - *Initial work* 

## License

This project is licensed under the MPLv2 License - see the [LICENSE](LICENSE) file for details.
