versao=$(git rev-parse HEAD | cut -c 1-7)
aws ecr get-login-password --region us-east-1 --profile bia | docker login --username AWS --password-stdin [SEU_REPOSITORIO]
docker build -t bia .
docker tag bia:latest [SEU_REPOSITORIO]/bia:$versao
docker push [SEU_REPOSITORIO]/bia:$versao
rm .env 2> /dev/null
./gerar-compose.sh
rm bia-versao-*zip
zip -r bia-versao-$versao.zip docker-compose.yml
git checkout docker-compose.yml