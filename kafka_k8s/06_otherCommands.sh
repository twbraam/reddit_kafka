echo "Hello CamelKafkaConnector" | kubectl exec -i my-cluster-kafka-0 -c kafka -- \
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic my-topic

# read the message from file
POD_NAME=$(kubectl get pods | grep my-connect | grep Running | cut -d " " -f1)

kubectl exec -i $POD_NAME -- cat /tmp/test.txt
kubectl exec -i $POD_NAME -- rm /tmp/test.txt



kubectl exec -i my-cluster-kafka-0 -c kafka -- bin/kafka-topics.sh --zookeeper localhost:2081 --alter --topic my-topic --config retention.ms=1000
kubectl exec -i my-cluster-kafka-0 -c kafka -- bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic my-topic --from-beginning
