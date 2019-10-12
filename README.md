[![Build Status](https://travis-ci.org/nicolaihald/toolbox.svg?branch=master)](https://travis-ci.org/nicolaihald/toolbox)
# Travis CLI 
Simple wrapper for running the travis-cli.

## Usage
Run the container from within your repository as the entire repo/source will mounted into the container:
```bash
docker run -it --rm -v $(pwd):/workspace --entrypoint=/bin/sh nicolaihald/travis-cli
```


### Login (using token)
Assuming you have already configured your reposotiry on https://travis-ci.org (open-source), you should be able to login using the cli within the container. 

> *To create a personal api token, navigate to https://github.com/settings/tokens.*
> _Travis requires the following permissions:_
> - *Read access to code*
> - *Read access to metadata and pull requests*
> - *Read and write access to administration, checks, commit statuses, and deployments.*
> 
> *Checkout https://docs.travis-ci.com/user/github-oauth-scopes for more details.*


```bash
travis login --github-token xxxxxx 

# Use the following command to verify your current identity:
travis whoami
```
  


### Encrypt sensitive data
During the execution of the `.travis.yml` file, Travis will automaticall decrypt secrets and interpret them as bash regular commands. To encrypt your token and add it as a `GITHUB_TOKEN` environment variable, run the following command: 

```bash
travis encrypt GITHUB_TOKEN=xxxxxx —-add
```
This will add the encrypted secret to your .travis.yml file. Alternatively, copy the generated "secret" into your .travis.yml file manually. 

To allow Travis to push images to docker hub, you can add an encrypted version of your credentials to your .travis.yml file using the following commands:

```bash
travis encrypt DOCKER_HUB_EMAIL=<email> --add
travis encrypt DOCKER_HUB_USERNAME=<username> --add
travis encrypt DOCKER_HUB_PASSWORD=<token> --add
```

### Adding environment variables directly to Travis: 
Alternatively, you can add the raw, uncrypted credentials directly: 
```bash
travis env set DOCKER_USERNAME username
travis env set DOCKER_PASSWORD password/token
```