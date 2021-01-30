CKC_VERSION="0.7.1"
STRIMZI_IMG="quay.io/strimzi/kafka:latest-kafka-2.7.0"
REGISTRY_USR="twbraam"

TMP="/tmp/my-connect"
BASEURL="https://repo1.maven.org/maven2/org/apache/camel/kafkaconnector"
PLUGINS=(
    "$BASEURL/camel-file-kafka-connector/$CKC_VERSION/camel-file-kafka-connector-$CKC_VERSION-package.zip"
    "https://github.com/kaliy/kafka-connect-rss/releases/download/kafka-connect-rss-0.1.0/kaliy-kafka-connect-rss-0.1.0.zip"
)

# download connect plugins
rm -rf $TMP && mkdir -p $TMP/plugins
for url in "${PLUGINS[@]}"; do
    curl -sL $url -o $TMP/plugins/file.zip && unzip -qq $TMP/plugins/file.zip -d $TMP/plugins
    rm -f $TMP/plugins/file.zip
done

# build and push the custom image
echo -e "FROM $STRIMZI_IMG\nCOPY ./plugins/ /opt/kafka/plugins/\nUSER 1001" > $TMP/Dockerfile
sudo docker build $TMP -t $REGISTRY_USR/my-connect:1.0.2
sudo docker login -u $REGISTRY_USR
sudo docker push $REGISTRY_USR/my-connect:1.0.2
docker tag twbraam/my-connect:1.0.2 twbraam/my-connect
sudo docker push $REGISTRY_USR/my-connect