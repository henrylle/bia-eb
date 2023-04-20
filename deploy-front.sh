API_ENDPOINT=$1
AMBIENTE=$2
REACT_APP_API_URL=$API_ENDPOINT SKIP_PREFLIGHT_CHECK=true npm run build --prefix client
echo '>> Fazendo deploy dos assets'
aws s3 sync client/build s3://bia-assets-eb/$AMBIENTE --exclude "index.html"

echo '>> Fazendo deploy do index.html'
aws s3 sync client/build s3://bia-assets-eb/$AMBIENTE --exclude "*" --include "index.html"