# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you use git deploy keys with your private repositories

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
Set your Heroku app's default buildpack to heroku-buildpack-compose
[Instructions](https://github.com/bwhmather/heroku-buildpack-compose)

You can probably use buildpack-multi, though I haven't tried.

### Step 6
Create a .buildpacks file if you already haven't in the root directory of your app. Make sure it includes this buildpack, and any other buildpacks you need. I'm using Ruby on Rails, so I have:

NOTE: Put this buildpack first!

```sh
$ cat .buildpacks

https://github.com/siassaj/heroku-buildpack-git-deploy-keys
https://github.com/heroku/heroku-buildpack-ruby
```

### 6
Commit the .buildpacks file to your repository and push to Heroku. Cross fingers.


#### Shoutout
This package draws very heavily from
https://github.com/fs-webdev/heroku-buildpack-ssh-keys
That project's gone now, but I'd still like to thank it's main writer Tim Shadel (https://github.com/timshadel) for the work.

[![alt Sentia.com.au](http://www.sentia.com.au/sentia-open-graph.png "Sentia ")](http://www.sentia.com.au)
