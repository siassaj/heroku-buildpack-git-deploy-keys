# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you add an SSH private key to an heroku app so it can access private GitHub repositories during `bundle install`

### Installation

The key have to be stored in the application's env:

```bash
heroku config:set GITHUB_DEPLOY_KEY="-----BEGIN RSA PRIVATE KEY-----...."
```

Then you have to install this buildpack on your app: [Instructions](https://devcenter.heroku.com/articles/platform-api-reference#buildpack-installations)

### Development / Testing

A great way to test is using Heroku's buildpack test runner. See https://github.com/heroku/heroku-buildpack-testrunner
