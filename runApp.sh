docker build -t "tuk_dak" .
docker run -d -p 1200:80 --name tuk_dak tuk_dak
