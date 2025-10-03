
#!/bin/bash
for i in {1..20}; do 
  curl -sk -o /dev/null -w "%{http_code}\n" \
  https://apigw.mashlab.com/coffee/ \
  -H "X-API-Key: COFFEE-12345"
done
