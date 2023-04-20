ambiente=$1 

if [ "$ambiente" = "hom" ]; then
    echo "Ambiente de homologação detectado."
    API_URL="https://hom.bia-aws.com.br"
    ./build.sh $API_URL
    ./deploy-front.sh $API_URL $ambiente
    eb deploy bia-hom-v2 --staged    
elif [ "$ambiente" = "dev" ]; then
    echo "Ambiente de desenvolvimento detectado."
    API_URL="https://dev.bia-aws.com.br"
    ./build.sh $API_URL
    ./deploy-front.sh $API_URL $ambiente
    eb deploy bia-dev-v2 --staged
else
    echo "Ambiente inválido. Saindo..."
    exit 1
fi