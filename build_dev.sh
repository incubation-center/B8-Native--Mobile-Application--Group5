docker build --build-arg NODE_ENV=development -t tukdak_backend:dev .
docker-compose -f docker-compose.dev.yml up --detach --build
