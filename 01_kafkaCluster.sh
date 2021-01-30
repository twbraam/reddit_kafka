# create a new namespace
kubectl create namespace kafka && kubectl config set-context --current --namespace=kafka

# deploy Strimzi operator
kubectl apply -f 'https://strimzi.io/install/latest?namespace=kafka'

# deploy Kafka cluster
kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml

# wait for ready
kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s