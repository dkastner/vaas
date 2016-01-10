docker build -t vaas-service -f Dockerfile .
docker build -t vaas-rspec -f Dockerfile.rspec .

echo "Starting VAAS"
docker rm -f vaas-service vaas-remote >/dev/null 2>&1
docker run -d --name vaas-remote vaas-service ruby /app/spec/remote.rb
docker run -d --link vaas-remote:example.com --name vaas-service vaas-service

echo "Running tests"
docker run --rm -it \
  --link vaas-service:example.com \
  --link vaas-service:vaas \
  -e VAAS_URL=http://vaas \
  vaas-rspec $@
STATUS=$?

echo "Stopping VAAS"
docker rm -f vaas-service vaas-remote

exit $STATUS
