package org.twbraam.processor.threads

import org.apache.flink.annotation.Public
import org.apache.flink.streaming.api.functions.source.FromIteratorFunction
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumerBase
import org.twbraam.processor.threads.sources.Kafka

object ThreadSource {

  @Public
  @SerialVersionUID(1L)
  case object Predef extends FromIteratorFunction[String](sources.Predef.unbounded)

  lazy val Kafka: FlinkKafkaConsumerBase[String] = sources.Kafka.consumer
}
