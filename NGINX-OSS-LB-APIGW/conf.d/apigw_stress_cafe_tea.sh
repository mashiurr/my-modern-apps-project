
#!/bin/bash
for i in {1..20}; do 
  curl -sk -o /dev/null -w "%{http_code}\n" \
  https://apigw.mashlab.com/tea/ \
  -H "X-API-Key: TEA-67890"
done
