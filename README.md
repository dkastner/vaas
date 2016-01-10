# VAAS: VCR as a Service

There may come a time when you outgrow your monolith and want to run integration
tests on a collection of services. You could manually code a stubbed out
service, but that's way too much work. Why not get the power of [VCR]() in your
integration tests?


VAAS records conversations between your integration test cluster and the outside
world and plays them back to prevent future test runs from requiring real
connections to third party services.

## Running

### As a docker container

Pretend you have a containerized webapp, fooapp that runs as a docker container
and it needs to talk to the twitter API at https://api.twitter.com.

```bash
docker run -p 8080:80 --name my-vaas dkastner/vaas
docker run -p 80:80 --link my-vaas:api.twitter.com fooapp
```

Now fooapp talks to vaas using the magic of docker's links instead of twitter.

### Stand-alone ruby process

You can run VAAS stand-alone by installing ruby >= 2.2 and running:

```bash
> bundle install
> rackup
```

It will listen on ports 80 for all web traffic.


## Test use

Now that you have VAAS running, configure the VAAS_URL, either through an
environment variable or via the DSL:

```bash
> export VAAS_URL=http://localhost
> ruby run_my_tests.rb
```

```ruby
require 'vaas'
VAAS.url = "http://localhost"
```

### Inside capybara

VAAS has capybara hooks built in that will record and play back interactions for
the duration of a scenario run. Just tag your scenarios with `@vaas`.


### Manually (Rspec, Test::Unit, etc).

```ruby
require 'vaas'

VAAS.configure do
  # Just like VCR's configuration
end

VAAS.use_cassette :some_service_http do
  SomeService.make_http_request
end
```
