# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you use git deploy keys with your private repositories


1) Register a deploy key for a github repository
[Github Instructions]([https://developer.github.com/guides/managing-deploy-keys/#deploy-keys)

2) Create a ```GITHUB_DEPLOY_KEY``` environment variable with the private key that you registered on your Heroku
[Heroku Instructions](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)

3) Set your Heroku app's default buildpack to heroku-buildpack-multi
[Instructions](https://github.com/heroku/heroku-buildpack-multi)

4) Create a .buildpacks file if you already haven't in the root directory of your app. Make sure it includes this buildpack, and any other buildpacks you need. I'm using Ruby on Rails, so I have:

```sh
$ cat .buildpacks

https://github.com/siassaj/heroku-buildpack-git-deploy-keys
https://github.com/heroku/heroku-buildpack-ruby
```

5) Commit the .buildpacks file to your repository and push to Heroku. Cross fingers.
