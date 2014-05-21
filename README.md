# Instapusher

Makes it easy to push to heroku.

## Installation

    gem install instapusher

## Setting up account

* Login at instapusher.com .
* Execute `instapusher --api-key` on local machine .

## Usage

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

## Setup Instapusher server

You can provide the env variable `LOCAL` like:

    instapusher --local

To enable debug messages do

    instapusher --debug

Pass host info like this

    INSTAPUSHER_HOST=instapusher.com instapusher

Also there are other env variables like `INSTAPUSHER_PROJECT` and `INSTAPUSHER_BRANCH`.

    INSTAPUSHER_HOST=instapusher.com INSTAPUSHER_PROJECT=rails INSTAPUSHER_BRANCH=master instapusher

ALSO you can pass your `api_key`

    API_KEY=xxxx instapusher

## What problem it solves

Here at BigBinary we create a separate branch for each feature we work
on. Let's say that I am working on `authentication with facebook`.
When I am done with the feature then I send pull request to my team
members to review. However in order to review the work all the team
members need to pull down the branch and fire up `rails server` and then
review.

We like to see things working. So we developed `instapusher` to push a
feature branch to heroku instantly with one command. Executing
`instapusher` prints a url and we put that url in the pull request so
that team members can actually test the feature.

## Here is how it works

A video is coming up.

## License

`instapusher` is released under MIT License.
