versao=$(git rev-parse HEAD | cut -c 1-7)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 449892995723.dkr.ecr.us-east-1.amazonaws.com
docker build -t bia .
docker tag bia:latest 449892995723.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 449892995723.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
rm .env 2> /dev/null
./gerar-compose.sh
rm bia-versao.zip
zip -r bia-versao.zip docker-compose.yml
git checkout docker-compose.yml