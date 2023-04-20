source utils.sh
BIA_API_URL=$1


versao=$(git rev-parse HEAD | cut -c 1-7)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 449892995723.dkr.ecr.us-east-1.amazonaws.com
checar_ultimo_comando
BIA_API_URL=$BIA_API_URL docker compose -f docker-compose-build-eb.yml build bia
checar_ultimo_comando
docker tag bia:latest 449892995723.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 449892995723.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
rm .env 2> /dev/null
checar_ultimo_comando
./gerar-compose.sh
checar_ultimo_comando
rm bia-versao.zip
zip -r bia-versao.zip docker-compose.yml
git checkout docker-compose.yml