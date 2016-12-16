# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you use git deploy keys with your private repositories

Multiple deploy keys for github aren't going to help you. If you follow 0.2.x tags you'll see me attempt to make that work. It's a pain. Better to set up a "machine user" as per github instructions if you need to pull down more than one repo.
### Step 1
Register a deploy key for a github repository
[Github Instructions](https://developer.github.com/guides/managing-deploy-keys/#deploy-keys)

### Step 2
Create a ```GIT_DEPLOY_KEY``` environment variable with the private key that you registered on your Heroku
[Heroku Instructions](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)

I do

```
heroku config:set GIT_DEPLOY_KEY="`cat /path/to/key`"
```

### Step 3
Create a ```GIT_HOST_HASH``` environment variable with the identification keys for the hosts that you're going to connect to. These are the keys found in ```~/.ssh/known_hosts```.

I backed up my ~/.ssh/known_hosts, connected to each host manually via ssh, and then did:

```
heroku config:set GIT_HOST_HASH="`cat ~/.ssh/known_hosts`"
```

Afterwards I restored my old known_hosts file.

### Step 4

Optionally configure `GIT_HOST` and `GIT_USER`. If not provided, they will default to `github.com` and `git` respectively.

```
heroku config:set GIT_HOST=my-git-host.example.com
heroku config:set GIT_USER=git-party
```

### Step 5
Use this custom repository as custom buildpack for heroku deployment.
This buildpack should be executed first as it takes care of setting up the SSH environment, for accessing private
repos.

```
heroku buildpacks:set --index 1 "https://github.com/rajaravivarma-r/heroku-buildpack-git-deploy-keys.git#develop"
heroku buildpacks:add 'heroku/ruby'
```
The `--index 1` tells heroku to run this custom buildpack before other buildpacks.
Read more about using third-party buildpacks in heroku https://devcenter.heroku.com/articles/third-party-buildpacks#using-a-custom-buildpack

`heroku buildpacks:add 'heroku/ruby'` tells heroku to use the default buildpack for Ruby applications.
Use the appropriate buildpack for your application.
Default buildpacks available in Heroku https://devcenter.heroku.com/articles/buildpacks#officially-supported-buildpacks

#### Shoutout
This package draws very heavily from
https://github.com/fs-webdev/heroku-buildpack-ssh-keys
That project's gone now, but I'd still like to thank it's main writer Tim Shadel (https://github.com/timshadel) for the work.

[![alt Sentia.com.au](http://www.sentia.com.au/sentia-open-graph.png "Sentia ")](http://www.sentia.com.au)
