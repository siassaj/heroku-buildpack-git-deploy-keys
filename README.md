# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you add an SSH private key to an heroku app so it can access private GitHub repositories during `bundle install`

### Installation

### Step 1
Create a ```GIT_DEPLOY_KEY``` environment variable with the private key that you registered on your Heroku
[Heroku Instructions](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)

I do

```
heroku config:set GIT_DEPLOY_KEY="`cat /path/to/key`"
```

### Step 2
Optionally configure `GIT_HOST`, `GIT_USER` and `GIT_HOST_HASH`. If not provided, they will default to `github.com`,`git` and github hashes respectively.

```
heroku config:set GIT_HOST=my-git-host.example.com
heroku config:set GIT_USER=git-party
heroku config:set GIT_HOST_HASH="git-host.example.com ssh-rsa AAABBBCCC...CCCXXX"
```

Getting the host key can be a pain so the following is a quick and dirty solution;
1st backup and clear out your ~/.ssh/known_hosts file, then connect to each host with ssh, which will prompt you with host hash fingerprint. Verify these and accept the connection.
When you're done doing that you can do

```
 heroku config:set GIT_HOST_HASH="`cat ~/.ssh/known_hosts`"
```

Then restore your known_hosts backup file.

### Step 3
Use this custom repository as custom buildpack for heroku deployment.
This buildpack should be executed first as it takes care of setting up the SSH environment, for accessing private
repos.

```
heroku buildpacks:set --index 1 "https://github.com/siassaj/heroku-buildpack-git-deploy-keys.git#master"
heroku buildpacks:add 'heroku/ruby'
```
The `--index 1` tells heroku to run this custom buildpack before other buildpacks.
Read more about using third-party buildpacks in heroku https://devcenter.heroku.com/articles/third-party-buildpacks#using-a-custom-buildpack

`heroku buildpacks:add 'heroku/ruby'` tells heroku to use the default buildpack for Ruby applications.
Use the appropriate buildpack for your application.
Default buildpacks available in Heroku https://devcenter.heroku.com/articles/buildpacks#officially-supported-buildpacks

### Development / Testing

#### WARNING
Testing on your local machine with the test runner _will_ clobber ~/.ssh/known_hosts and  ~/.ssh/private_key file if they exist. I just destroyed my ~/.ssh/id_rsa and ~/.ssh/known_hosts testing this. I renamed the key being used to private_key (also because we can't be sure it'll be an RSA id anyway) so it should be less devastating but you've been warned. Best is probably to chmod everything in ~/.ssh to 0400.

A great way to test is using Heroku's buildpack test runner. See https://github.com/heroku/heroku-buildpack-testrunner. To set up, run these commands:

#### Shoutout
This package draws very heavily from
https://github.com/fs-webdev/heroku-buildpack-ssh-keys
That project's gone now, but I'd still like to thank it's main writer Tim Shadel (https://github.com/timshadel) for the work.

[![alt Sentia.com.au](http://www.sentia.com.au/sentia-open-graph.png "Sentia ")](http://www.sentia.com.au)
