docker build --build-arg NODE_ENV=production -t tukdak_backend:prod .
docker-compose -f docker-compose.prod.yml up --detach --build
