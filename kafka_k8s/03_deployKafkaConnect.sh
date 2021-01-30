kubectl apply -f 03_deployKafkaConnect.yml

kubectl wait deployment/my-connect-connect --for=condition=Available --timeout=300s