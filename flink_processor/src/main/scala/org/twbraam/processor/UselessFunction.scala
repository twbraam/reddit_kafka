package org.twbraam.processor

import com.google.protobuf.any.Any.messageCompanion
import org.apache.flink.api.common.functions.MapFunction
import io.circe._
import scalapb_circe.JsonFormat

class UselessFunction extends MapFunction[String, Float] {
  override def map(r: String): Float = {

    val json = JsonFormat.fromJsonString(r)
    print(json)

    0.001f
  }
}