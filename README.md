# Kong API Management in Docker

## Installation
1. Simply run `make` to configure all the services and start up the Kong dashboard at `http://localhost:8080`

## Description
1. The dashboard seen is the [PGBI](https://github.com/PGBI/kong-dashboard) dashboard which provides a visual way to interact with your running instance of the Kong API gateway
2. The project comes configured with one API and one consumer 
3. The API is a Jokes API which will supply a new joke everytime you hit the upstream endpoint
    - It is protected by the `key-auth` plugin
4. The consumer is a simple user that is configured with a secret key

## Usage
1. Once the installation is complete and your docker infrastructure is up and running, on your terminal run: 
`curl -iL -X GET  --url http://localhost:8000/joke   --header 'Host: joke.com' --header "apikey: samrat_secret_key"`
    - You should see a joke printed out
2. To demonstrate Kong's `key-auth` plugin protection, remove the `apikey` header from the curl request: `curl -iL -X GET  --url http://localhost:8000/joke   --header 'Host: joke.com'`
    - You should see a `{"message":"No API key found in request"}` resoponse
3. Now let's try invalid credentials: `curl -iL -X GET  --url http://localhost:8000/joke   --header 'Host: joke.com' --header "apikey: invalid_key"`
    - You should see a `{"message":"Invalid authentication credentials"}` response

## References
[Original article](https://medium.com/smileinnovation/kong-manage-your-flask-apis-d58ff4ea808d)