# Instapusher

Makes it easy to push an application to heroku.

### Installation

    gem install instapusher

## Setting up account

* Login at instapusher.com .
* Execute `instapusher --api-key` on local machine .

### Usage

In order to deploy your code first make sure that you are in the branch that you want to deploy.
Then execute this command.

```
instapusher
```

It detects project name and a branch from the git repo and starts deploying your project.

### Running background jobs and other rake tasks

Instapusher does not create workers on heroku for your project.
Background jobs or rake tasks should be run manually from the console.

``` sh
heroku run rake <TASK_NAME> --app <APP_NAME_GIVEN_BY_INSTAPUSHER>
```

For eg. to run delayed job workers

``` sh
heroku run rake jobs:work --app my-awesome-app-42-add-devise-authentication-ip
```

### How to setup webhook

![pic](https://api.monosnap.com/image/download?id=RAcyMFB5XbHbycsptMZnanTLN3L2oi)

### Deleting old instances

Heroku allows only 100 instances. Once 100 applications have been created by instapusher account then heroku does not create any new application and instapusher starts failing.

In order to delete old instances visit the project project and then "More" > "Reached limit".

### License

`instapusher` is released under MIT License.
